#include "iac.h"

#import "iac_app_delegate.h"

#if VERSION_MAJOR == 4
#import "platform/ios/godot_app_delegate.h"
#else
#import "platform/iphone/godot_app_delegate.h"
#endif

#import <Foundation/Foundation.h>

#if VERSION_MAJOR == 4
typedef PackedByteArray GodotByteArray;
#define GODOT_FLOAT_VARIANT_TYPE Variant::FLOAT
#define GODOT_BYTE_ARRAY_VARIANT_TYPE Variant::PACKED_BYTE_ARRAY
#else
typedef PoolByteArray GodotByteArray;
#define GODOT_FLOAT_VARIANT_TYPE Variant::REAL
#define GODOT_BYTE_ARRAY_VARIANT_TYPE Variant::POOL_BYTE_ARRAY
#endif

IAC *IAC::instance = NULL;
IACAppDelegate *iacAppDelegate = nil;

void IAC::_bind_methods() {
	ClassDB::bind_method(D_METHOD("get_pending_event_count"), &IAC::get_pending_event_count);
	ClassDB::bind_method(D_METHOD("pop_pending_event"), &IAC::pop_pending_event);
};

void IAC::invocation(String payload) {
	Dictionary ret;
	ret["payload"] = payload;
	pending_events.push_back(ret);
}

int IAC::get_pending_event_count() {
	return pending_events.size();
};

Variant IAC::pop_pending_event() {
	Variant front = pending_events.front()->get();
	pending_events.pop_front();

	return front;
};

IAC *IAC::get_singleton() {
	return instance;
};

IAC::IAC() {
	ERR_FAIL_COND(instance != NULL);
	instance = this;
	iacAppDelegate = [[IACAppDelegate alloc] init];
	[GodotApplicalitionDelegate addService:iacAppDelegate];
}

IAC::~IAC() {}
