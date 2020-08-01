//
//  PrivateAPI.h
//  MobaMac
//
//  Created by user on 2019/11/28.
//  Copyright © 2019 rinsuki. All rights reserved.
//

#import <WebKit/WebKit.h>

#ifndef PrivateAPI_h
#define PrivateAPI_h

@interface WKWebView (WKPrivate)
@property (nonatomic, setter=_setPageZoomFactor:) double _pageZoomFactor;
@property (nonatomic, setter=_setAllowsRemoteInspection:) BOOL _allowsRemoteInspection;
@property (nonatomic, setter=_setOverrideDeviceScaleFactor:) CGFloat _overrideDeviceScaleFactor;

@end

@interface WKPreferences (WKPrivate)
@property (nonatomic, setter=_setDeveloperExtrasEnabled:) BOOL _developerExtrasEnabled;

@end

#endif /* PrivateAPI_h */
