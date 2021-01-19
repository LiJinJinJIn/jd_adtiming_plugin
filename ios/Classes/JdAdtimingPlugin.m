#import "JdAdtimingPlugin.h"
#if __has_include(<jd_adtiming_plugin/jd_adtiming_plugin-Swift.h>)
#import <jd_adtiming_plugin/jd_adtiming_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jd_adtiming_plugin-Swift.h"
#endif

@implementation JdAdtimingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJdAdtimingPlugin registerWithRegistrar:registrar];
}
@end
