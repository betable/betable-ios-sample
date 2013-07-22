//
//  ViewController.m
//  TestApp
//
//  Created by Tony Hauber on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Betable/Betable.h>
#import "ViewController.h"

@interface ViewController () {
    UIButton *_betButton;
    UIButton *_unbackedBetButton;
    UIButton *_creditBetButton;
    UIButton *_unbackedCreditBetButton;
    UIButton *_batchedBetButton;
    UIButton *_accountButton;
    UIButton *_walletButton;
    UIButton *_profileButton;
    UIButton *_logoutButton;
}
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 20)];
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
    
    
    /* Setting up unbacked authorization button */
    unbackedAuthorizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [unbackedAuthorizeButton setFrame:CGRectMake(10, 100, 300, 40)];
    [unbackedAuthorizeButton setTitle:@"Unbacked Authorize" forState:UIControlStateNormal];
    [unbackedAuthorizeButton setTitle:@"Unbacked Authorized" forState:UIControlStateDisabled];
    [unbackedAuthorizeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [[self view] addSubview:unbackedAuthorizeButton];
    [unbackedAuthorizeButton addTarget:self action:@selector(unbackedAuthorize:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        
    /* Setting up bet button */
    _betButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_betButton setFrame:CGRectMake(10, 150, 145, 40)];
    [_betButton setTitle:@"Bet" forState:UIControlStateNormal];
    [[self view] addSubview:_betButton];
    [_betButton addTarget:self action:@selector(bet:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up unbacked-bet button */
    _unbackedBetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_unbackedBetButton setFrame:CGRectMake(165, 150, 145, 40)];
    [_unbackedBetButton setTitle:@"Unbacked Bet" forState:UIControlStateNormal];
    [[self view] addSubview:_unbackedBetButton];
    [_unbackedBetButton addTarget:self action:@selector(unbackedBet:)
                forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    

    /* Setting up bet button */
    _creditBetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_creditBetButton setFrame:CGRectMake(10, 200, 145, 40)];
    [_creditBetButton setTitle:@"Credit Bet" forState:UIControlStateNormal];
    [[self view] addSubview:_creditBetButton];
    [_creditBetButton addTarget:self action:@selector(creditBet:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up unbacked-bet button */
    _unbackedCreditBetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_unbackedCreditBetButton setFrame:CGRectMake(165, 200, 145, 40)];
    [_unbackedCreditBetButton setTitle:@"UB Credit Bet" forState:UIControlStateNormal];
    [[self view] addSubview:_unbackedCreditBetButton];
    [_unbackedCreditBetButton addTarget:self action:@selector(unbackedCreditBet:)
                forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up batched bet button */
    _batchedBetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_batchedBetButton setFrame:CGRectMake(10, 250, 300, 40)];
    [_batchedBetButton setTitle:@"Batched Bet Request" forState:UIControlStateNormal];
    [[self view] addSubview:_batchedBetButton];
    [_batchedBetButton addTarget:self action:@selector(batchedBet:)
                forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up account lookup button */
    _accountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_accountButton setFrame:CGRectMake(10, 300, 145, 40)];
    [_accountButton setTitle:@"Get Account" forState:UIControlStateNormal];
    [[self view] addSubview:_accountButton];
    [_accountButton addTarget:self action:@selector(account:)
        forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up wallet lookup button */
    _walletButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_walletButton setFrame:CGRectMake(165, 300, 145, 40)];
    [_walletButton setTitle:@"Get Wallet" forState:UIControlStateNormal];
    [[self view] addSubview:_walletButton];
    [_walletButton addTarget:self action:@selector(wallet:)
            forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    /* Setting up profile button */
    _profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_profileButton setFrame:CGRectMake(10, 350, 300, 40)];
    [_profileButton setTitle:@"Profile" forState:UIControlStateNormal];
    [[self view] addSubview:_profileButton];
    [_profileButton addTarget:self action:@selector(profile:)
           forControlEvents:(UIControlEvents)UIControlEventTouchDown];

    /* Setting up logout button */
    _logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_logoutButton setFrame:CGRectMake(10, 400, 300, 40)];
    [_logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [[self view] addSubview:_logoutButton];
    [_logoutButton addTarget:self action:@selector(logout:)
            forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    
    CGRect overlayFrame = CGRectMake(0, 0, 480, 480);
    overlayView = [[UIView alloc] initWithFrame:overlayFrame];
    overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,40,40)];
    spinner.center = self.view.center;
    [self unsetAuthUI];
    [overlayView addSubview:spinner];
    [spinner startAnimating];
}
- (void)setAuthUI {
    [authorizeButton setEnabled:NO];
    _unbackedCreditBetButton.enabled = YES;
    _unbackedBetButton.enabled = YES;
    _logoutButton.enabled = YES;
    if (authUnbacked == NO) {
        _betButton.enabled = YES;
        _creditBetButton.enabled = YES;
        _batchedBetButton.enabled = YES;
        _accountButton.enabled = YES;
        _walletButton.enabled = YES;
        _profileButton.enabled = YES;
    }
    [unbackedAuthorizeButton setEnabled:NO];
}
- (void)unsetAuthUI {
    [authorizeButton setEnabled:YES];
    _unbackedBetButton.enabled = NO;
    _unbackedCreditBetButton.enabled = NO;
    _betButton.enabled = NO;
    _creditBetButton.enabled = NO;
    _batchedBetButton.enabled = NO;
    _accountButton.enabled = NO;
    _walletButton.enabled = NO;
    _profileButton.enabled = NO;
    _logoutButton.enabled = NO;
    [unbackedAuthorizeButton setEnabled:YES];
    
}
- (void)alertAuthorized {
    [overlayView removeFromSuperview];
    [self setAuthUI];
}
- (void)alertAuthorizeFailed {
    [overlayView removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authorization Was Denied"
                                                    message:@"Please try to authorize again"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
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
                onComplete:^(NSString* accessToken){
        NSLog(@"accessToken: %@", accessToken);
        if (accessToken) {
            [self performSelectorOnMainThread:@selector(alertAuthorized) withObject:self waitUntilDone:NO];
        } else {
            [self performSelectorOnMainThread:@selector(alertAuthorizeFailed) withObject:self waitUntilDone:NO];
        }
    }
                 onFailure:^(NSURLResponse *response, NSString *responseBody, NSError *error){
        NSLog(@"%@", error);
    }];
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
- (void)creditBet:(id)sender {
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"GBP", @"currency",
                          @"sandbox", @"economy",
                          @"0.01", @"wager",
                          nil];
    [betable creditBetForGame:@"Cm0QnIXtvp6fzZOL3ymORq"
             creditGame:@"YZIJyG1Wsl_rLGvFAlp89C"
               withData:data
             onComplete:^(NSDictionary *data){
                 NSLog(@"%@", data);
             }
              onFailure:^(NSURLResponse *response, NSString *responseBody, NSError *error){
                  NSLog(@"%@", responseBody);
              }];
}
- (void)unbackedCreditBet:(id)sender {
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"0.01", @"wager",
                          nil];
    [betable unbackedCreditBetForGame:@"Cm0QnIXtvp6fzZOL3ymORq"
                           creditGame:@"YZIJyG1Wsl_rLGvFAlp89C"
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
- (void)batchedBet:(id)sender {
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
    NSDictionary *creditData = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"GBP", @"currency",
                          @"sandbox", @"economy",
                          @"0.01", @"wager",
                          nil];
    NSDictionary *unbackedCreditData = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"0.01", @"wager",
                                nil];
    BetableBatchRequest *batch = [[BetableBatchRequest alloc] initWithBetable:betable];
    [batch betForGame:@"Cm0QnIXtvp6fzZOL3ymORq" withData:data withName:@"Bet-1"];
    [batch unbackedBetForGame:@"Cm0QnIXtvp6fzZOL3ymORq" withData:data withName:@"Unbacked-Bet-1"];
    [batch betForGame:@"Cm0QnIXtvp6fzZOL3ymORq" withData:data withName:@"Bet-2"];
    [batch creditBetForGame:@"Cm0QnIXtvp6fzZOL3ymORq" creditGame:@"YZIJyG1Wsl_rLGvFAlp89C" withData:creditData withName:@"Credit-Bet-1"];
    [batch unbackedCreditBetForGame:@"Cm0QnIXtvp6fzZOL3ymORq" creditGame:@"YZIJyG1Wsl_rLGvFAlp89C" withData:unbackedCreditData withName:@"Unbacked-Credit-Bet-1"];
    [batch runBatchOnComplete:^(NSDictionary *data){
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
- (void)logout:(id)sender {
    [betable logout];
    [self unsetAuthUI];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
#pragma mark - Orientation Stuff

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

// pre-iOS 6 support
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
