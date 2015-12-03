//
//  StartViewController.m
//  ScienceBowlScorecard
//
//  Created by Ashley on 3/2/15.
//  Copyright (c) 2015 Ashley Dumaine. All rights reserved.
//

#import "StartViewController.h"
#import "ViewController.h"

@interface StartViewController () {
    int fieldCount;
}

@end

@implementation StartViewController

@synthesize team_a;
@synthesize team_b;
@synthesize location;
@synthesize scorekeeper;
@synthesize startButton;
@synthesize navBar;
@synthesize division;
@synthesize roundNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:21],
                                    NSFontAttributeName, nil]];
    fieldCount = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) textFieldDidBeginEditing: (UITextField *) textField {
    //[self.scrollView setContentOffset:CGPointMake(0,textField.center.y-90) animated:YES];
}

//LEAKS OCCURRING HERE
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.roundNum || fieldCount >= 5) {
        [textField resignFirstResponder];
        fieldCount++;
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (textField == self.location) {
        [self.roundNum becomeFirstResponder];
        fieldCount++;
        [self.scrollView setContentOffset:CGPointMake(0,self.roundNum.center.y-90) animated:YES];
    }
    else if (textField == self.scorekeeper) {
        [self.location becomeFirstResponder];
        fieldCount++;
        [self.scrollView setContentOffset:CGPointMake(0,self.location.center.y-90) animated:YES];
    }
    else if (textField == self.team_b) {
        [self.scorekeeper becomeFirstResponder];
        fieldCount++;
        [self.scrollView setContentOffset:CGPointMake(0,self.scorekeeper.center.y-90) animated:YES];
        
    }
    else if (textField == self.team_a) {
        [self.team_b becomeFirstResponder];
        fieldCount++;
        [self.scrollView setContentOffset:CGPointMake(0,self.team_b.center.y-90) animated:YES];
    }
    if (fieldCount == 5) { //enabled as soon as it hits 4, doesn't matter if it is greater for edits
        self.startButton.enabled = YES;
    }
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *controller = [segue destinationViewController];
    controller.team_a = self.team_a.text;
    controller.team_b = self.team_b.text;
    controller.location = self.location.text;
    controller.scorekeeper = self.scorekeeper.text;
    controller.roundNum = self.roundNum.text;
    controller.division = [self.division titleForSegmentAtIndex:self.division.selectedSegmentIndex];
}


@end