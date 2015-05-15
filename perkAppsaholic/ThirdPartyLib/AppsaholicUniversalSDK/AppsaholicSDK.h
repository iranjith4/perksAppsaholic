//
//  AppsaholicSDK.h
//  AppsaholicSDK
//
//  Created by abhijeet upadhyay on 30/12/14.
//  Copyright (c) 2014 Perk. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"


typedef void (^InitialiseSDK) (BOOL success, NSString *status);
typedef void (^TrackEvent) (BOOL success , NSString *notificationtext, NSNumber *pointEarned);
typedef void (^FetchNotificationSuccess) (BOOL success);
typedef void (^UserStatusChange) (BOOL success);


@interface AppsaholicSDK : NSObject{
    

}
/**
 A must property to assign to work SDK. SDK needs to know application controller from where it needs to present portal and other options.
 */

@property (strong, nonatomic) UIViewController *rootViewController;

/**
 An optional BOOL property so define if after watching Ad user wants to move to Portal or wants to get back to Application. By default it is set to 
 "FALSE" and user will be back to Application.
 */
@property (nonatomic)BOOL moveToPortal;


/**
Singleton to access instance functions.
*/
+ (id)sharedManager;

/**
 SDK initialisation success call back.
*/

- (void)startSession:(NSString*)appKey withSuccess:(InitialiseSDK)success;

/**
 SDK track event one time tap success call back.
 */
- (void)trackEvent:(NSString*)eventID notificationType:(BOOL)custom  withController:(UIViewController*)eventRootController withSuccess:(TrackEvent)success;


/**
 Show Portal with root view controller for point claim purpose
 */
-(void)showPortal;

/**
 Claim Point for custom banner call.
 */

-(void)claimPoints;

/**
 Fetch unclaimed notification call
 */
-(void)fetchNotifications:(FetchNotificationSuccess)success;

/**
 Unclaimed notification web page call.
 */
-(void)claimNotificationPage;

/**
 Close button, offset (top, middle, bottom), text color, background color, button color, button text color, and animation options(flyLeft,flyRight,flyUp,flyDown,fadeIn)
 */
-(void)notificationCustomization:(UIColor*)textColor
                  andCloseButtonOffSet:(NSString*)offset
           withBackgraoundColor:(UIColor*)backGroundColor
                 withButtonColor:(UIColor*)buttonColor
             withButtonTextColor:(UIColor*)buttonTextColor
             withAnimationOption:(NSString*)animationOption
           withInfoOption:(BOOL)infoOption;



/**
Change User status
 */
-(void)changeUserStatus:(UserStatusChange)success;



@end
