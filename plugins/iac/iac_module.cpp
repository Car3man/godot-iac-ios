#include "iac_module.h"

#include "core/version.h"

#if VERSION_MAJOR == 4
#include "core/config/engine.h"
#else
#include "core/engine.h"
#endif

#include "core/version.h"

#include "iac.h"

IAC *iac;

void godot_iac_init() {
	iac = memnew(IAC);
	Engine::get_singleton()->add_singleton(Engine::Singleton("GodotIAC", iac));
}

void godot_iac_deinit() {
	if (iac) {
		memdelete(iac);
	}
}