//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Jorge Salcedo on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray * operandStack;
@end


@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *) operandStack 
{
    if (_operandStack == nil)
        _operandStack = [[NSMutableArray alloc] init];
    
    return _operandStack;
}

- (void) setOperandStack:(NSMutableArray *)operandStack
{
    _operandStack = operandStack;
}

-(void)clearOperation 
{
    self.operandStack = nil; 
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double) popOperand 
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0; 
    //calculate result 
    if ( [operation isEqualToString:@"+"] ) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([@"cos" isEqualToString:operation] ) {
        double num = [self popOperand];
        result = cos(num);
    } else if ([@"sin" isEqualToString:operation] ) {
        double num = [self popOperand];
        result = sin(num);
    } else if ([@"sqrt" isEqualToString:operation] ) {
        double num = [self popOperand];
        result = sqrt(num);
    }

    
    [self pushOperand:result];
    
    return result;
}
@end
