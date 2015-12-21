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

@synthesize teamA;
@synthesize teamB;
@synthesize location;
@synthesize scorekeeper;
@synthesize startButton;
@synthesize navBar;
@synthesize division;
@synthesize roundType;
@synthesize roundNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:21],
                                    NSFontAttributeName, nil]];
    fieldCount = 0;
    self.roundType.apportionsSegmentWidthsByContent = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.roundNum || fieldCount >= 5) {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (textField == self.location) {
        [self.roundNum becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,self.roundNum.center.y-90) animated:YES];
    }
    else if (textField == self.scorekeeper) {
        [self.location becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,self.location.center.y-90) animated:YES];
    }
    else if (textField == self.teamB) {
        [self.scorekeeper becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,self.scorekeeper.center.y-90) animated:YES];
        
    }
    else if (textField == self.teamA) {
        [self.teamB becomeFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0,self.teamB.center.y-90) animated:YES];
    }
    if ([self.teamB hasText] && [self.teamA hasText] && [self.scorekeeper hasText] && [self.location hasText] && [self.roundNum hasText]) {
        self.startButton.enabled = YES;
    }
    return YES;
}

- (IBAction)checkRoundType:(UISegmentedControl *)roundTypeSelector {
    NSString *selection = [roundTypeSelector titleForSegmentAtIndex:roundTypeSelector.selectedSegmentIndex];
    self.division.enabled = [selection isEqualToString:@"Wildcard"] || [selection isEqualToString:@"Civil War"] || [self.roundNum.text.capitalizedString containsString:@"Final"] ? NO : YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *controller = [segue destinationViewController];
    controller.teamA = self.teamA.text;
    controller.teamB = self.teamB.text;
    controller.location = self.location.text;
    controller.scorekeeper = self.scorekeeper.text;
    controller.roundNum = self.roundNum.text;
    controller.roundType = [self.roundType titleForSegmentAtIndex:self.roundType.selectedSegmentIndex];
    controller.division = self.division.enabled ? [self.division titleForSegmentAtIndex:self.division.selectedSegmentIndex] : @"N/A";
}


@end