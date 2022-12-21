module main

pub struct ConsumableResources[T] {
mut:
	total_resources Resources
	used_resources map[T]Resources
}

// GETTERS
pub fn (cr &ConsumableResources[T]) get_total_resources() Resources {
	return cr.total_resources
}

// FUNCTIONS
pub fn (cr &ConsumableResources[T]) has_used_resources() bool {
	return cr.used_resources.len > 0 
}

pub fn (cr &ConsumableResources[T]) get_free_resources() Resources {
	used_resources := cr.get_used_resources()
	return cr.total_resources - used_resources
}

pub fn (cr &ConsumableResources[T]) get_used_resources() Resources {
	mut used_resources := Resources{}
	for _, used in cr.used_resources {
		used_resources.add(used)
	}
	return used_resources
}

pub fn (cr &ConsumableResources[T]) can_consume(resources &Resources) bool {
	used_resources := cr.get_used_resources()
	return (used_resources + resources) <= cr.total_resources
}

pub fn (mut cr ConsumableResources[T]) consume(consumption_id T, resources &Resources) ? {
	if consumption_id in cr.used_resources {
 		return error("already consumed resources with consumtion_id ${consumption_id}")
 	}
 	if !cr.can_consume(resources) {
 		return error("not enough resources")
 	}

 	cr.used_resources[consumption_id] = resources
}

pub fn (mut cr ConsumableResources[T]) free_resources(consumption_id T) {
	cr.used_resources.delete(consumption_id)
}