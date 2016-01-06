//
//  ToolKitConstants.h
//  WFZhihu
//
//  Created by xiupintech on 16/1/4.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#ifndef ToolKitConstants_h
#define ToolKitConstants_h

//弱引用
#define WS(weakSelf)  __weak __typeof(self)weakSelf = self;


#define DELAYEXECUTE(delayTime,func) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{func;}))

#ifndef DLog
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif
#endif

#endif /* ToolKitConstants_h */
