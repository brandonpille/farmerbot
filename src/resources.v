module main

pub struct Resources {
mut:
    hru u64
	sru u64
    cru u64
    mru u64
}

// GETTERS
pub fn (r &Resources) get_hru() u64 {
    return r.hru
}

pub fn (r &Resources) get_sru() u64 {
    return r.sru
}

pub fn (r &Resources) get_cru() u64 {
    return r.cru
}

pub fn (r &Resources) get_mru() u64 {
    return r.mru
}

// SETTERS
pub fn (mut r Resources) set_hru(hru u64) {
    r.hru = hru
}

pub fn (mut r Resources) set_sru(sru u64) {
    r.sru = sru
}

pub fn (mut r Resources) set_cru(cru u64) {
    r.cru = cru
}

pub fn (mut r Resources) set_mru(mru u64) {
    r.mru = mru
}

// FUNCTIONS
pub fn empty() Resources {
    return Resources {
        hru: 0
        sru: 0
        cru: 0
        mru: 0
    }
}

pub fn (r &Resources) clone() Resources {
    return Resources{
        hru: r.hru
        sru: r.sru
        cru: r.cru
        mru: r.mru
    }
}

pub fn (a Resources) < (b Resources) bool {
    return a.hru < b.hru && a.sru < b.sru && a.cru < b.cru && a.mru < b.mru
}

pub fn (a Resources) == (b Resources) bool {
    return a.hru == b.hru && a.sru == b.sru && a.cru == b.cru && a.mru == b.mru
}

pub fn (a Resources) + (b Resources) Resources {
    return Resources{
        hru: a.hru + b.hru
        sru: a.sru + b.sru
        cru: a.cru + b.cru
        mru: a.mru + b.mru
    }
}

pub fn (a Resources) - (b Resources) Resources {
    mut substraction := a.clone()
    substraction.substract(b)
    return substraction
}

pub fn (r &Resources) is_empty() bool {
    return r.cru == 0 && r.sru == 0 && r.hru == 0 && r.mru == 0
}

pub fn (mut r Resources) add(other &Resources) {
    r.hru += other.hru
    r.sru += other.sru
    r.cru += other.cru
    r.mru += other.mru
}

pub fn (mut r Resources) substract(other &Resources) {
    if r.hru < other.hru {
        r.hru = 0
    } else {
        r.hru -= other.hru
    }
    
    if r.sru < other.sru {
        r.sru = 0
    } else {
        r.sru -= other.sru
    }
    
    if r.cru < other.cru {
        r.cru = 0
    } else {
        r.cru -= other.cru
    }
    
    if r.mru < other.mru {
        r.mru = 0
    } else {
        r.mru -= other.mru
    }
}

pub fn (r &Resources) can_substract(other &Resources) bool {
    if r.hru < other.hru || r.sru < other.sru || r.cru < other.cru || r.mru < other.mru {
        return false
    }
    return true
}

