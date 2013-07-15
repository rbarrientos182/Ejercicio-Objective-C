//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Roberto Alfonso Barrientos Balbuena on 24/10/12.
//  Copyright (c) 2012 Roberto Alfonso Barrientos Balbuena. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack
{
    if(!_operandStack)
    {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

-(void) pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(void) clearOperandStack //función que permite borrar todos los elementos que hay dentro de operanStack
{

    [self.operandStack removeAllObjects];
}

-(double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject) [self.operandStack removeLastObject];
    return  [operandObject doubleValue];
}

-(double) performOperation:(NSString *)operation
{
    double result = 0;
    
    if([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
        
    }
    else if ([@"*" isEqualToString:operation])
    {
        result = [self popOperand] * [self popOperand];
    
    }
    
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
        
    }
    
    else if ([operation isEqualToString:@"/"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] / subtrahend;
        
    }
    
    else if ([operation isEqualToString:@"sin"])     {
        result = sin([self popOperand]*180.0/M_PI);//calculamos el seno dado que el resultado toma como operando un ángulo en radianes, si queremos tratar los operandos en grados hay que hacer la transformación (*180.0/M_PI).

    }
    
    else if ([operation isEqualToString:@"cos"])
    {
        result = cos([self popOperand]*180.0/M_PI);//calculamos el coseno dado que el resultado toma como operando un ángulo en radianes, si queremos tratar los operandos en grados hay que hacer la transformación (*180.0/M_PI).

    }
    
    else if ([operation isEqualToString:@"sqrt"])
    {
        result = sqrt([self popOperand]); //aqui calculamos la raíz cuadrada del operando
    }
    
    else if ([operation isEqualToString:@"π"]) //aqui obtenemos el valor de pi que se obtiene de la constante M_PI
    {
        result = M_PI;
    }
    
    [self pushOperand:result];
    
    return result;
}

@end
