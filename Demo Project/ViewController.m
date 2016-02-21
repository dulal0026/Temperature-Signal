//
//  ViewController.m
//  Demo Project
//
//  Created by Dulal on 2/19/16.
//  Copyright © 2016 Dulal Hossain. All rights reserved.
//

#import "ViewController.h"
#import "JFADoubleSlider.h"


@interface ViewController ()<JFADoubleSliderDelegate>{
    float lowerTemp;
    float higerTemp;
    float currentTemp;
}

#define OUT_OF_RANGE_COLOR [UIColor colorWithRed:0.9232 green:0.0354 blue:0.0685 alpha:1.0]
#define MARGINAL_COLOR [UIColor colorWithRed:0.9431 green:0.1804 blue:0.218 alpha:1.0]
#define NORMAL_COLOR [UIColor colorWithRed:0.0118 green:0.7882 blue:0.6627 alpha:1.0]

@property (strong, nonatomic) IBOutlet JFADoubleSlider *iBDoubleSlider;

@property (weak, nonatomic) IBOutlet UITextField *currentTemperatureTextField;

@property (weak, nonatomic) IBOutlet UISwitch *currentTemperatureSwitch;

@end

@implementation ViewController
- (IBAction)switchValueChange:(id)sender {
}

//-----------------------------------------------------
#pragma mark - ViewController LifeCycle
//-----------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.iBDoubleSlider.delegate=self;
    self.iBDoubleSlider.reportInteger = NO;
    
    currentTemp=80;
    higerTemp=90;
    lowerTemp=70;
    
    self.currentTemperatureTextField.text=[NSString stringWithFormat:@"%ld\u00B0",(long)currentTemp];
    
    [self updateUIColor:currentTemp lower:lowerTemp higher:higerTemp];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------
#pragma mark - Util Methods
//------------------------------------------------------


-(void)updateUIColor:(float)current lower:(float)lower higher:(float)higer{
    // 1. Out of range
    if(current < lower || current > higer) {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.backgroundColor = OUT_OF_RANGE_COLOR;
        }];
    }
    // 2. Marginal
    else if(current < lower+5) {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.backgroundColor = [self gradiantFrom:MARGINAL_COLOR to:NORMAL_COLOR percent:(current-lower)/5.0];
        }];
    } else if(current > higer-5) {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.backgroundColor = [self gradiantFrom:MARGINAL_COLOR to:NORMAL_COLOR percent:(higer-current)/5.0];
        }];
    }
    // 3. Normal
    else {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.backgroundColor = NORMAL_COLOR;
        }];
    }
    
}

// Percent is 0-1
-(UIColor *) gradiantFrom:(UIColor *) color1 to:(UIColor *) color2 percent:(float) percent {
    CGFloat c1r, c1g, c1b, c1a;
    CGFloat c2r, c2g, c2b, c2a;
    CGFloat c3r, c3g, c3b, c3a;
    
    [color1 getRed:&c1r green:&c1g blue:&c1b alpha:&c1a];
    [color2 getRed:&c2r green:&c2g blue:&c2b alpha:&c2a];
    
    c3r = (c2r-c1r)*percent + c1r;
    c3g = (c2g-c1g)*percent + c1g;
    c3b = (c2b-c1b)*percent + c1b;
    c3a = (c2a-c1a)*percent + c1a;
    
    return [UIColor colorWithRed:c3r green:c3g blue:c3b alpha:c3a];
}

//-----------------------------------------------------
#pragma mark - UITextField Delegate
//-----------------------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.currentTemperatureTextField.text=@"";
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]){
      textField.text=[NSString stringWithFormat:@"%ld\u00B0",(long)currentTemp];
    }
    else {
        currentTemp=[textField.text integerValue];
       textField.text=[NSString stringWithFormat:@"%ld\u00B0",(long)currentTemp];
    }
     [self updateUIColor:currentTemp lower:lowerTemp higher:higerTemp];
}

//-----------------------------------------------------
#pragma mark - JFADoubleSliderDelegate
//-----------------------------------------------------

- (void)minValueChanged:(float)minValue{
    lowerTemp=minValue;
    [self updateUIColor:currentTemp lower:lowerTemp higher:higerTemp];
}

- (void)maxValueChanged:(float)maxValue{
    higerTemp=maxValue;
    [self updateUIColor:currentTemp lower:lowerTemp higher:higerTemp];
}

@end