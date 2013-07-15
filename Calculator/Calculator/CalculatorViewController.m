//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Roberto Alfonso Barrientos Balbuena on 23/10/12.
//  Copyright (c) 2012 Roberto Alfonso Barrientos Balbuena. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
    
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    
    if(self.userIsTheMiddleOfEnteringANumber)
    {
        
        if([sender.currentTitle isEqualToString:@"."]) //comprobamos si el numero es flotante
        {
            NSRange range = [self.display.text rangeOfString:sender.currentTitle];
            if(range.location ==   NSNotFound)
            {
                self.display.text =  [self.display.text stringByAppendingString:digit];
            }
        }
        else
        {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }
    }
    else
    {
        
        if([sender.currentTitle isEqualToString:@"."])
        {
            self.display.text = [@"0" stringByAppendingString:digit];
        }
        else
        {
            self.display.text = digit;
        }
        userIsTheMiddleOfEnteringANumber = YES;
    }
    
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsTheMiddleOfEnteringANumber = NO;
    NSString *valor = [self.display.text stringByAppendingString:@" "];
    self.stack.text = [self.stack.text stringByAppendingString:valor];
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if(self.userIsTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    NSString *valor = [operation stringByAppendingString:@"= "];
    self.stack.text = [self.stack.text stringByAppendingString:valor];
    
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    
    NSString *valor2 = [self.display.text stringByAppendingString:@" "];
    self.stack.text = [self.stack.text stringByAppendingString:valor2];
}

- (IBAction)clearStack //metodo para reinicializar los labels y el stack de los arreglos
{
    self.display.text = @"0";
    self.stack.text = @" ";
    [self.brain clearOperandStack];
    self.userIsTheMiddleOfEnteringANumber = NO;
    
}

- (void)viewDidUnload {
    [self setStack:nil];
    [super viewDidUnload];
}
@end
