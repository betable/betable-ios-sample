//
//  AppDelegate.h
//  TestApp
//
//  Created by Tony Hauber on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Betable/betable.h>
#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    ViewController *viewController;
    Betable *betable;
}

@property (strong, nonatomic) UIWindow *window;

@end
