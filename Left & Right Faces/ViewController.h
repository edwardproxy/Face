//
//  ViewController.h
//  Left & Right Faces
//
//  Created by Edward Sun on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, GADBannerViewDelegate>

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) UIImage *rightImage;
@property (nonatomic, strong) UIImage *orgImage;
@property bool bLeft;
@property bool bRight;
@property bool bOrg;

@property (nonatomic, strong) UIView *bannerContainerView;
@property (nonatomic, strong) GADBannerView *bannerView;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *switchButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *flashButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *snapButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *redoButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appSecret;
@property (nonatomic, strong) NSString *tokenKey;
@property (nonatomic, strong) NSString *tokenSecret;

- (IBAction)swithCamera:(id)sender;
- (IBAction)swithFlash:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)redoPhoto:(id)sender;
- (IBAction)savePhoto:(id)sender;
- (void)showLeft;
- (void)showRight;
- (void)showOrg;
- (IBAction)segValueChanged:(id)sender;

@end
