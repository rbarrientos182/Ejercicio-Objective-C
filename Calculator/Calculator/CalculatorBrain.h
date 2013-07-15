//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Roberto Alfonso Barrientos Balbuena on 24/10/12.
//  Copyright (c) 2012 Roberto Alfonso Barrientos Balbuena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand:(double)operand;
-(double) performOperation:(NSString *)operation;
-(void) clearOperandStack;

@end
