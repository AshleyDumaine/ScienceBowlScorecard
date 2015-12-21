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
    NSMutableArray *teams;
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
    self.roundType.apportionsSegmentWidthsByContent = YES;

    NSString *rosterTeams = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"roster" ofType:@"txt"] encoding:NSMacOSRomanStringEncoding error:nil];
    teams = [[NSMutableArray alloc]initWithArray:[rosterTeams componentsSeparatedByString:@"\n"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.roundNum) {
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
    if ([self.scorekeeper hasText] && [self.location hasText] && [self.roundNum hasText]) {
        self.startButton.enabled = YES;
    }
    return YES;
}

- (IBAction)checkRoundType:(UISegmentedControl *)roundTypeSelector {
    NSString *selection = [roundTypeSelector titleForSegmentAtIndex:roundTypeSelector.selectedSegmentIndex];
    self.division.enabled = [selection isEqualToString:@"Wildcard"] || [selection isEqualToString:@"Civil War"] || [self.roundNum.text.capitalizedString containsString:@"Final"] ? NO : YES;
}

# pragma mark - Picker View Data Source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    return [teams count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* tView = (UILabel*)view;
    if (!tView) {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
        tView.textColor = [UIColor whiteColor];
        tView.numberOfLines = 2;
    }
    tView.text = [teams objectAtIndex:row];
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *controller = [segue destinationViewController];
    controller.teamA = [teams objectAtIndex:[self.teamA selectedRowInComponent:0]];
    controller.teamB = [teams objectAtIndex:[self.teamB selectedRowInComponent:0]];
    controller.location = self.location.text;
    controller.scorekeeper = self.scorekeeper.text;
    controller.roundNum = self.roundNum.text;
    controller.roundType = [self.roundType titleForSegmentAtIndex:self.roundType.selectedSegmentIndex];
    controller.division = self.division.enabled ? [self.division titleForSegmentAtIndex:self.division.selectedSegmentIndex] : @"N/A";
}


@end