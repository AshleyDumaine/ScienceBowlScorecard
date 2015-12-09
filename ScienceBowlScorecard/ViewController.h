//
//  ViewController.h
//  ScienceBowlScorecard
//
//  Created by Ashley on 3/1/15.
//  Copyright (c) 2015 Ashley Dumaine. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate> {
}

@property (weak, nonatomic) IBOutlet UILabel* team_a_score;
@property (weak, nonatomic) IBOutlet UILabel* team_b_score;
@property (nonatomic) NSString* team_a;
@property (nonatomic) NSString* team_b;
@property (nonatomic) NSString* location;
@property (nonatomic) NSString* scorekeeper;
@property (nonatomic) NSString* division;
@property (nonatomic) NSString* roundNum;
-(IBAction)awardTossupA:(id)sender;
-(IBAction)awardTossupB:(id)sender;
-(IBAction)awardBonusA:(id)sender;
-(IBAction)awardBonusB:(id)sender;
-(IBAction)interruptA:(id)sender;
-(IBAction)interruptB:(id)sender;
-(IBAction)distractA:(id)sender;
-(IBAction)distractB:(id)sender;

-(IBAction)redo:(id)sender;
-(IBAction)undo:(id)sender;
-(IBAction)sendResults:(id)sender;
-(IBAction)startNewRound:(id)sender;
@end