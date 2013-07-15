//
//  ViewController.m
//  TestApp
//
//  Created by Tony Hauber on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Betable/Betable.h>
#import "ViewController.h"

@interface ViewController ()
-(void)setAuthUI;
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
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 20)] autorelease];
    label.text = @"Test App";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.adjustsFontSizeToFitWidth = YES;
    [[self view] addSubview:label];
    
    /* Setting up authorization button */
    authorizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [authorizeButton setFrame:CGRectMake(10, 50, 300, 40)];
    [authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    [authorizeButton setTitle:@"Authorized" forState:UIControlStateDisabled];
    [authorizeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [[self view] addSubview:authorizeButton];
    [authorizeButton addTarget:self action:@selector(authorize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        
    /* Setting up bet button */
    UIButton *betButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [betButton setFrame:CGRectMake(10, 100, 300, 40)];
    [betButton setTitle:@"Bet" forState:UIControlStateNormal];
    [[self view] addSubview:betButton];
    [betButton addTarget:self action:@selector(bet:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up account lookup button */
    UIButton *accountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [accountButton setFrame:CGRectMake(10, 150, 300, 40)];
    [accountButton setTitle:@"Get Account" forState:UIControlStateNormal];
    [[self view] addSubview:accountButton];
    [accountButton addTarget:self action:@selector(account:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up wallet lookup button */
    UIButton *walletButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [walletButton setFrame:CGRectMake(10, 200, 300, 40)];
    [walletButton setTitle:@"Get Wallet" forState:UIControlStateNormal];
    [[self view] addSubview:walletButton];
    [walletButton addTarget:self action:@selector(wallet:)
            forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up unbacked authorization button */
    unbackedAuthorizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [unbackedAuthorizeButton setFrame:CGRectMake(10, 250, 300, 40)];
    [unbackedAuthorizeButton setTitle:@"Unbacked Authorize" forState:UIControlStateNormal];
    [unbackedAuthorizeButton setTitle:@"Unbacked Authorized" forState:UIControlStateDisabled];
    [unbackedAuthorizeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [[self view] addSubview:unbackedAuthorizeButton];
    [unbackedAuthorizeButton addTarget:self action:@selector(unbackedAuthorize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];

    /* Setting up unbacked-bet button */
    UIButton *unbackedBetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [unbackedBetButton setFrame:CGRectMake(10, 300, 300, 40)];
    [unbackedBetButton setTitle:@"Unbacked Bet" forState:UIControlStateNormal];
    [[self view] addSubview:unbackedBetButton];
    [unbackedBetButton addTarget:self action:@selector(unbackedBet:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up profile button */
    UIButton *profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [profileButton setFrame:CGRectMake(10, 350, 300, 40)];
    [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
    [[self view] addSubview:profileButton];
    [profileButton addTarget:self action:@selector(profile:)
           forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    
    CGRect overlayFrame = CGRectMake(0, 0, 480, 480);
    overlayView = [[UIView alloc] initWithFrame:overlayFrame];
    overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,40,40)] autorelease];
    spinner.center = self.view.center;
    [overlayView addSubview:spinner];
    [spinner startAnimating];
}
- (void)setAuthUI {
    [authorizeButton setEnabled:NO];
    [inAppAuthButton setEnabled:NO];
    [unbackedAuthorizeButton setEnabled:NO];
}
- (void)alertAuthorized {
    [overlayView removeFromSuperview];
    [self setAuthUI];
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
    authUnbacked = NO;
    [self.view addSubview:overlayView];
    BetableAccessTokenHandler authCompleteHandler = ^(NSString* accessToken){
        NSLog(@"accessToken: %@", accessToken);
        if (accessToken) {
            [self alertAuthorized];
        } else {
            [self alertAuthorizeFailed];
        }
    };
    BetableFailureHandler authFailureHandler = ^(NSURLResponse *response, NSString *responseBody, NSError *error){
        NSLog(@"%@", error);
    };
    BetableCancelHandler authCancelHandler = ^{
        [overlayView removeFromSuperview];
    };
    [betable authorizeInViewController:self
               onAuthorizationComplete:authCompleteHandler
                             onFailure:authFailureHandler
                              onCancel:authCancelHandler];
}
- (void)unbackedAuthorize:(id)sender {
    authUnbacked = YES;
    [self.view addSubview:overlayView];
    [betable unbackedToken:@"foobarbaz"
                onComplete:[^(NSString* accessToken){
        NSLog(@"accessToken: %@", accessToken);
        if (accessToken) {
            [self performSelectorOnMainThread:@selector(alertAuthorized) withObject:self waitUntilDone:NO];
        } else {
            [self performSelectorOnMainThread:@selector(alertAuthorizeFailed) withObject:self waitUntilDone:NO];
        }
    } autorelease]
                 onFailure:[^(NSURLResponse *response, NSString *responseBody, NSError *error){
        NSLog(@"%@", error);
    } autorelease]];
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
- (void)unbackedBet:(id)sender {
    NSArray *paylines = [NSArray arrayWithObject:
                         [NSArray arrayWithObjects:
                          [NSNumber numberWithInt:1],
                          [NSNumber numberWithInt:1],
                          [NSNumber numberWithInt:1],
                          nil]];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          paylines, @"paylines",
                          @"0.01", @"wager",
                          nil];
    [betable unbackedBetForGame:@"Cm0QnIXtvp6fzZOL3ymORq"
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
- (void)profile:(id)sender {
    BetableWebViewController *profile = [[BetableWebViewController alloc] initWithURL:@"http://betable.com" onCancel:nil];
    [self presentModalViewController:profile animated:YES];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
