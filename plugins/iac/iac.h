#ifndef IAC_H
#define IAC_H

#include "core/version.h"

#if VERSION_MAJOR == 4
#include "core/object/class_db.h"
#else
#include "core/object.h"
#endif

class IAC : public Object {

	GDCLASS(IAC, Object);

	static IAC *instance;
	static void _bind_methods();

	List<Variant> pending_events;

public:
    void invocation(String payload);
	int get_pending_event_count();
	Variant pop_pending_event();

	static IAC *get_singleton();

	IAC();
	~IAC();
};

#endif
