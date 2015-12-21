//
//  ViewController.m
//  ScienceBowlScorecard
//
//  Created by Ashley on 3/1/15.
//  Copyright (c) 2015 Ashley Dumaine. All rights reserved.
//

#import "ViewController.h"
//use 2 stacks: one for executed actions, one for undone actions
//popping off executed stack pushes onto undone stack
//redoing pops off undone stack and pushes onto executed action stack

@interface ViewController () {
    NSMutableArray* executedStack;
    NSMutableArray* undoneStack;
}
@end

@implementation ViewController

@synthesize team_a_score;
@synthesize team_b_score;

- (void)viewDidLoad {
    [super viewDidLoad];
    executedStack = [[NSMutableArray alloc] init];
    undoneStack = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)incrementScore: (int) value forTeamScore: (UILabel*) teamScore {
    [teamScore setText:[NSString stringWithFormat:@"%d", [teamScore.text intValue] + value]];
}

-(IBAction)awardTossupA:(id)sender {
    [self incrementScore:4 forTeamScore:team_a_score];
    [executedStack addObject:@"A + 4"];
}
-(IBAction)awardTossupB:(id)sender {
    [self incrementScore:4 forTeamScore:team_b_score];
    [executedStack addObject:@"B + 4"];
}
-(IBAction)awardBonusA:(id)sender {
    [self incrementScore:10 forTeamScore:team_a_score];
    [executedStack addObject:@"A + 10"];
}
-(IBAction)awardBonusB:(id)sender {
    [self incrementScore:10 forTeamScore:team_b_score];
    [executedStack addObject:@"B + 10"];
}
-(IBAction)interruptA:(id)sender { //give 4 points to OTHER team (B)
    [self awardTossupB:sender];
}
-(IBAction)interruptB:(id)sender { //give 4 points to OTHER team (A)
    [self awardTossupA:sender];
}
-(IBAction)distractA:(id)sender { //give 10 points to OTHER team (B)
    [self awardBonusB:sender];
}
-(IBAction)distractB:(id)sender { //give 10 points to OTHER team (A)
    [self awardBonusA:sender];
}

-(IBAction)redo:(id)sender {
    //pop the stack
    NSString* lastOp = [undoneStack lastObject];
    [undoneStack removeLastObject];
    if ([lastOp isEqualToString:@"A - 4"]) {
        [self incrementScore:4 forTeamScore:team_a_score];
        [executedStack addObject:@"A + 4"];
    }
    else if ([lastOp isEqualToString:@"A - 10"]) {
        [self incrementScore:10 forTeamScore:team_a_score];
        [executedStack addObject:@"A + 10"];
    }
    else if ([lastOp isEqualToString:@"B - 4"]) {
        [self incrementScore:4 forTeamScore:team_b_score];
        [executedStack addObject:@"B + 4"];
    }
    else if ([lastOp isEqualToString:@"B - 10"]) {
        [self incrementScore:10 forTeamScore:team_b_score];
        [executedStack addObject:@"B + 10"];
    }
}

-(IBAction)undo:(id)sender {
    //pop the stack
    NSString* lastOp = [executedStack lastObject];
    [executedStack removeLastObject];
    if ([lastOp isEqualToString:@"A + 4"]) {
        [self incrementScore:-4 forTeamScore:team_a_score];
        [undoneStack addObject:@"A - 4"];
    }
    else if ([lastOp isEqualToString:@"A + 10"]) {
        [self incrementScore:-10 forTeamScore:team_a_score];
        [undoneStack addObject:@"A - 10"];
    }
    else if ([lastOp isEqualToString:@"B + 4"]) {
        [self incrementScore:-4 forTeamScore:team_b_score];
        [undoneStack addObject:@"B - 4"];
    }
    else if ([lastOp isEqualToString:@"B + 10"]) {
        [self incrementScore:-10 forTeamScore:team_b_score];
        [undoneStack addObject:@"B - 10"];
    }
}

-(IBAction)sendResults:(id)sender {
    if ([MFMailComposeViewController canSendMail]){
        NSString *emailTitle = [NSString stringWithFormat: @"[Science Bowl] %@ Round %@ Results", self.roundType, self.roundNum];
        NSString *messageBody = [NSString stringWithFormat:@"Here are the results for the following match:\n%@ versus %@\nDivision: %@\nLocation: %@\nModerator: %@\nRound Number: %@\n\nFinal Score\n%@: %d\n%@: %d", self.teamA, self.teamB, self.division, self.location, self.scorekeeper, self.roundNum, self.teamA, [self.team_a_score.text intValue], self.teamB, [self.team_b_score.text intValue]];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        NSLog(@"%@", messageBody); // debug
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:@[@"ashley.dumaine@uconn.edu"]]; //TODO: replace with Science Bowl email before releasing
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else {
        NSLog(@"This device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"Sent email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)startNewRound:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Start New Round?"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) [self performSegueWithIdentifier:@"StartNewRound" sender:self];
}
@end