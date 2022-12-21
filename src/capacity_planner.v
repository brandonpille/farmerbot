module main

pub interface ICapacityPlannerPolicy {
    find_suitable_nodes(nodes []Node) ![]u32
}

pub struct CapacityPlannerPolicyAny {
    resources Resources
    features []NodeFeatures
}

pub fn (p &CapacityPlannerPolicyAny) find_suitable_nodes(nodes []Node) ![]u32 {
 	mut suitable_nodes := nodes.filter(it.can_consume_resources(p.resources))
 	if suitable_nodes.len == 0 {
 		return error("No node available with the required resources!")
 	}
 	suitable_nodes = suitable_nodes.filter(it.has_features(p.features))
 	if suitable_nodes.len == 0 {
 		return error("No node available with the required features")
 	}
	return suitable_nodes.map(it.id)
}

pub struct CapacityPlannerPolicyNode {
    node_id u32
}

pub fn (p &CapacityPlannerPolicyNode) find_suitable_nodes(nodes []Node) ![]u32 {
     suitable_nodes := nodes.filter(it.id == p.node_id)
     if suitable_nodes.len != 1 {
         error("Node with id ${p.node_id} does not exist!")
     }
     if suitable_nodes[0].is_being_used() {
         error("Cannot rent the full node as it is already in use by another contract.")
     }
     return suitable_nodes.map(it.id)
}

pub struct CapacityPlannerPolicyExclusive {
    group_id u32
    resources Resources
    features []NodeFeatures
}

pub fn (p &CapacityPlannerPolicyExclusive) find_suitable_nodes(nodes []Node) ![]u32 {
     return error("Not implemented yet")
}

pub struct CapacityPlanner {
}

pub fn (c &CapacityPlanner) find_suitable_node(policy &ICapacityPlannerPolicy, available_nodes []Node) ![]u32 {
    mut nodes := available_nodes.clone()
    // sort the nodes on power state to use nodes that are on first
     nodes.sort_with_compare(fn (a &Node, b &Node) int {
         if a.power_state == b.power_state {
             return 0
         } else if u8(a.power_state) < u8(b.power_state) {
             return -1
         } else {
             return 1
        }
    })
    // find suitable nodes based on the policy
    suitable_nodes := policy.find_suitable_nodes(nodes)!
    return suitable_nodes
}