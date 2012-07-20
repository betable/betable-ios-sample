//
//  ViewController.m
//  TestApp
//
//  Created by Tony Hauber on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (ViewController*)initWithBetable:(Betable*)aBetable{
    self = [self init];
    if (self) {
        betable = aBetable;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *newView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)] autorelease];
    [newView setBackgroundColor:[UIColor whiteColor]];
    [[self view] addSubview:newView];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 20)] autorelease];
    label.text = @"Test App";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.adjustsFontSizeToFitWidth = YES;
    [[self view] addSubview:label];
    
    /* Setting up authorization button */
    authorizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [authorizeButton setFrame:CGRectMake(10, 60, 300, 40)];
    [authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    [authorizeButton setTitle:@"Authorized" forState:UIControlStateDisabled];
    [authorizeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [[self view] addSubview:authorizeButton];
    [authorizeButton addTarget:self action:@selector(authorize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up bet button */
    UIButton *betButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [betButton setFrame:CGRectMake(10, 110, 300, 40)];
    [betButton setTitle:@"Bet" forState:UIControlStateNormal];
    [[self view] addSubview:betButton];
    [betButton addTarget:self action:@selector(bet:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up account lookup button */
    UIButton *accountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [accountButton setFrame:CGRectMake(10, 160, 300, 40)];
    [accountButton setTitle:@"Get Account" forState:UIControlStateNormal];
    [[self view] addSubview:accountButton];
    [accountButton addTarget:self action:@selector(account:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up wallet lookup button */
    UIButton *walletButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [walletButton setFrame:CGRectMake(10, 210, 300, 40)];
    [walletButton setTitle:@"Get Wallet" forState:UIControlStateNormal];
    [[self view] addSubview:walletButton];
    [walletButton addTarget:self action:@selector(wallet:)
            forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    CGRect overlayFrame = self.view.frame;
    overlayView = [[UIView alloc] initWithFrame:overlayFrame];
    overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,40,40)] autorelease];
    spinner.center = overlayView.center;
    [overlayView addSubview:spinner];
    [spinner startAnimating];
}
- (void)alertAuthorized {
    [overlayView removeFromSuperview];
    [authorizeButton setEnabled:NO];
}
- (void)alertAuthorizeFailed {
    [overlayView removeFromSuperview];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Authorization Was Denied"
                                                    message:@"Please try to authorize again"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil] autorelease];
    [alert show];
}
- (void)authorize:(id)sender {
    [self.view addSubview:overlayView];
    [betable authorize];
}
- (void)bet:(id)sender {
    NSArray *paylines = [NSArray arrayWithObject:
                            [NSArray arrayWithObjects:
                                [NSNumber numberWithInt:1],
                                [NSNumber numberWithInt:1],
                                [NSNumber numberWithInt:1],
                             nil]];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"GBP", @"currency",
                          @"sandbox", @"economy",
                          paylines, @"paylines",
                          @"0.01", @"wager",
                          nil];
    [betable betForGame:@"Cm0QnIXtvp6fzZOL3ymORq"
               withData:data
             onComplete:^(NSDictionary *data){
                 NSLog(@"%@", data);
             }
              onFailure:^(NSURLResponse *response, NSString *responseBody, NSError *error){
                  NSLog(@"%@", responseBody);
              }];
}
- (void)account:(id)sender {
    [betable userAccountOnComplete:^(NSDictionary *data){
                 NSLog(@"%@", data);
             }
              onFailure:^(NSURLResponse *response, NSString *responseBody, NSError *error){
                  NSLog(@"%@", responseBody);
              }];
}
- (void)wallet:(id)sender {
    [betable userWalletOnComplete:^(NSDictionary *data){
                            NSLog(@"%@", data);
                        }
                         onFailure:^(NSURLResponse *response, NSString *responseBody, NSError *error){
                             NSLog(@"%@", responseBody);
                         }];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
