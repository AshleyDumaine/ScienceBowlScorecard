//
//  StartViewController.h
//  ScienceBowlScorecard
//
//  Created by Ashley on 3/2/15.
//  Copyright (c) 2015 Ashley Dumaine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController <UITextFieldDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField* teamA;
@property (weak, nonatomic) IBOutlet UITextField* teamB;
@property (weak, nonatomic) IBOutlet UITextField* location;
@property (weak, nonatomic) IBOutlet UITextField* scorekeeper;
@property (weak, nonatomic) IBOutlet UITextField* roundNum;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* startButton;
@property (weak, nonatomic) IBOutlet UINavigationBar* navBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl* division;
@property (weak, nonatomic) IBOutlet UISegmentedControl* roundType;
@end
