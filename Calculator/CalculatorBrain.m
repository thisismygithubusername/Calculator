//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Jorge Salcedo on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
const double PI = 3.14159265359;
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end


@implementation CalculatorBrain
@synthesize programStack = _programStack;

- (NSMutableArray *) programStack 
{
    if (_programStack == nil)
        _programStack = [[NSMutableArray alloc] init];
    
    return _programStack;
}

-(void)clearOperation 
{
    self.programStack = nil; 
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}
//Get rid of this 
/*
- (double) popOperand 
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}
*/
- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}
//Getter for read only 
-(id)program 
{
    return [self.programStack copy];
}

+(NSString *)descriptionOfProgram:(id)program
{
    return @"implement in assigment 2";
}

+(double)runProgram:(id)program
{
    NSMutableArray *stack; 
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

+(double) popOperandOffStack:(NSMutableArray *)stack
{
    double result =0;
    
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    if([topOfStack isKindOfClass: [NSNumber class]])
    {
        result = [topOfStack doubleValue];
    } 
    else if ([topOfStack isKindOfClass:[NSString class]]){
        
        NSString *operation = topOfStack;
        
        if ( [operation isEqualToString:@"+"] ) {
            result = [self popOperandOffStack:stack] +
                     [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * 
                     [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        } else if ([@"/" isEqualToString:operation]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) result = [self popOperandOffStack:stack] / divisor;
        } else if ([@"cos" isEqualToString:operation] ) {
            double num = [self popOperandOffStack:stack];
            result = cos(num);
        } else if ([@"sin" isEqualToString:operation] ) {
            double num = [self popOperandOffStack:stack];
            result = sin(num);
        } else if ([@"sqrt" isEqualToString:operation] ) {
            double num = [self popOperandOffStack:stack];
            result = sqrt(num);
        }else if ([@"π" isEqualToString:operation] ) {
            result = PI;
        }
    }
    return result;
}
/*
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
    }else if ([@"π" isEqualToString:operation] ) {
        result = PI;
    }
 


    
    [self pushOperand:result];
    
    return result;
*/
@end
