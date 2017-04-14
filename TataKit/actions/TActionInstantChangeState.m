//
//  TActionInstantChangeState.m
//  TataViewer
//
//  Created by Albert Li on 10/16/14.
//  Copyright (c) 2014 Tataland. All rights reserved.
//

#import "TActionInstantChangeState.h"
#import "SMXMLDocument.h"
#import "TUtil.h"
#import "TScene.h"
#import "TActor.h"

@implementation TActionInstantChangeState

- (id)init {
    if (self = [super init]) {
        self.name = @"Change State";
        self.icon = [UIImage imageNamed:@"icon_action_changestate"];
        
        self.actor = @"";
        self.state = @"";
    }
    
    return self;
}

- (void)clone:(TAction *)target {
    [super clone:target];
    
    TActionInstantChangeState* targetAction = (TActionInstantChangeState*)target;
    targetAction.actor = self.actor;
    targetAction.state = self.state;
}

- (BOOL)parseXml:(SMXMLElement *)xml {
    if (xml == nil || ![xml.name isEqualToString:@"ActionInstantChangeState"])
        return NO;
    
    if (![super parseXml:xml])
        return NO;
    
    @try {
        self.actor = [TUtil parseStringXElement:[xml childNamed:@"Actor"] default:@""];
        self.state = [TUtil parseStringXElement:[xml childNamed:@"State"] default:@""];
        return YES;
    } @catch (NSException* e) {
        NSLog(@"Error: %@", e);
        return NO;
    }
}

- (SMXMLElement*)toXml {
    NOT_IMPLEMENTED_METHOD
}

#pragma mark - Launch Methods

- (void)reset:(long long)time {
    [super reset:time];
}

- (BOOL)step:(id<TTataDelegate>)delegate time:(long long)time {

    TActor* targetActor = (TActor*)[[delegate currentScene] findLayer:self.actor];
    if (targetActor != nil)
        targetActor.run_state = self.state;
    
    return [super step:delegate time:time];
}

@end
