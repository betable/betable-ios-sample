//
//  ViewController.h
//  TestApp
//
//  Created by Tony Hauber on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController{
    Betable *betable;
    UIButton *authorizeButton;
    UIView *overlayView;
}
- (ViewController*)initWithBetable:(Betable*)aBetable;
- (void)authorize:(id)sender;

- (void)bet:(id)sender;
- (void)account:(id)sender;
- (void)wallet:(id)sender;

- (void)alertAuthorized;
- (void)alertAuthorizeFailed;
@end
