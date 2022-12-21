module main

pub enum NodeFeatures as u32 {
	public_node
}

pub enum PowerState as u8 {
    up
    down
}

pub struct Node {
	id u32
mut:
	resources ConsumableResources[u64]
	power_state PowerState
	has_public_config bool
}

// GETTERS
pub fn (n &Node) get_power_state() PowerState {
	return n.power_state
}

// SETTERS
pub fn (mut n Node) set_power_state(power_state PowerState) {
	n.power_state = power_state
}

// FUNCTIONS
pub fn (n &Node) is_being_used() bool {
 	return n.resources.has_used_resources()
}

pub fn (n &Node) can_consume_resources(resources &Resources) bool {
	return n.resources.can_consume(resources)
}

pub fn (mut n Node) consume_resources(consumption_id u64, resources &Resources) ? {
	return n.resources.consume(consumption_id, resources)
}

pub fn (mut n Node) free_resources(consumption_id u64) {
	n.resources.free_resources(consumption_id)
}

pub fn (n &Node) has_features(features []NodeFeatures) bool {
	for feature in features {
		match feature {
			.public_node {
				if !n.has_public_config {
					return false
				}
			}
		}
	}
	return true
}