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
    NSInteger lowerTemp;
    NSInteger higerTemp;
    NSInteger currentTemp;
}
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


-(void)updateUIColor:(NSInteger)current lower:(NSInteger)lower higher:(NSInteger)higer{
    
    if (lower<current && current<higer) {
        
        [UIView animateWithDuration:2.0 animations:^{
            self.view.backgroundColor = [UIColor greenColor];
        }];
    }
    else{
        [UIView animateWithDuration:2.0 animations:^{
            self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.149 blue:0.0745 alpha:1.0];
        }];
    }
    /*
    else if (current<lower || current>higer-5){
        if (current==lower-5 || current==higer-5) {
            
            [UIView animateWithDuration:2.0 animations:^{
                self.view.backgroundColor = [UIColor colorWithRed:0.9431 green:0.1804 blue:0.218 alpha:1.0];
            }];
            return;
        }
        
        [UIView animateWithDuration:2.0 animations:^{
            self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.149 blue:0.0745 alpha:1.0];
        }];
    }*/
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

- (void)minIntValueChanged:(int)minIntValue{
    lowerTemp=minIntValue;
    [self updateUIColor:currentTemp lower:lowerTemp higher:higerTemp];
}

- (void)maxIntValueChanged:(int)maxIntValue{
    higerTemp=maxIntValue;
    [self updateUIColor:currentTemp lower:lowerTemp higher:higerTemp];
}

@end