
// extend
#macro UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK	false

// Абстрактный класс
function UNIT_TmTimer() 
	: __UNIT_TmTimerPreprocessor()
	constructor {
	
	#region __private
	
	static __init = __UNIT_tmVoid /* handler, timer         */;
	static __tick = __UNIT_tmVoid /* handler, timer, super  */;
	static __free = __UNIT_tmVoid /* handler, timer, inTick */;
	
	
	static __set_f = function(_name, _f) {
		if (is_undefined(_f) || _f == __UNIT_tmVoid)
			variable_struct_remove(self, _name);
		else
			self[$ _name] = _f;
	}
	
	static __set_finit = function(_f) {
		self.__set_f("__init", _f);
	}
	
	static __set_ftick = function(_f) {
		self.__set_f("__tick", _f);
	}
	
	static __set_ffree = function(_f) {
		self.__set_f("__free", _f);
	}
	
	#endregion
	
	static unbind = function() {
		
		return UNIT_tmUnbind(self);
	}
	
	static isBind = function() {
		
		return UNIT_tmIsBind(self);
	}
	
	static getBind = function() {
		
		return UNIT_tmGetBind(self);
	}
	
	static toString = function() {
		return ("UNIT::timer::" + instanceof(self));
	}
	
	static isTimer = function() {
		return true;
	}
	
	static isHandler = function() {
		return false;
	}
	
	
	static _set = function(_key, _value) {
		self[$ _key] = _value;
		return self;
	}
	
	static _ext = function(_struct, _replace=true) {
		
		var _keys = variable_struct_get_names(_struct);
	    var _size = array_length(_keys), _key;
	    while (_size > 0) {
        
	        _key = _keys[--_size];
	        if (!_replace and variable_struct_exists(self, _key)) continue;
	        self[$ _key] = _struct[$ _key];
	    }
		
		return self;
	}
	
	
	static _get_finit = function() {
		return self.__init;
	}
	
	static _get_ftick = function() {
		return self.__tick;
	}
	
	static _get_ffree = function() {
		return self.__free;
	}
	
}

/// @param			timer
/// @description	Отвяжет таймер от обработчика 
//					и вернёт true, если таймер был отвязан
function UNIT_tmUnbind(_timer) {
	static _map = __UNIT_tmHandlerMap();
	var _cell = _map[? _timer];
	if (_cell == undefined) return false;
	
	_cell[__UNIT_TM_CELL._HANDLER].__unbind(_cell, false);
	return true;
}

/// @param			timer
/// @description	Вернёт привязан ли таймер к чему-то
function UNIT_tmIsBind(_timer) {
	static _map = __UNIT_tmHandlerMap();
	return ds_map_exists(_map, _timer);
}

/// @param			timer
/// @description	Вернёт обработчик, к которому привязан таймер
//					Если не привязан вернёт undefined
function UNIT_tmGetBind(_timer) {
	static _map = __UNIT_tmHandlerMap();
	var _cell = _map[? _timer];
	if (_cell != undefined) return _cell[__UNIT_TM_CELL._HANDLER];
}


#region __private

function __UNIT_TmTimerPreprocessor() constructor {
	
	if (UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK) {
	
	self.__mark = weak_ref_create(self);
	self.__mark_ref = undefined;
	
	}
	
	if (UNIT_PREPROCESSOR_TM_ENABLE_DEBUG) {
	
	self.__debug_time = 0;
	
	}
	
	// этот метод нельзя переопределять
	static __copyn_ = function(_struct) {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		var _keys = variable_struct_get_names(_struct);
		var _size = array_length(_keys), _key;
		while (_size > 0) {
			
			_key = _keys[--_size];
			if (string_char_at(_key, 1) != "_")
				self[$ _key] = _struct[$ _key];
		}
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
		
		if (instanceof(self) == instanceof(_struct) && (
			self._get_ftick() != _struct._get_ftick() ||
			self._get_finit() != _struct._get_finit() ||
			self._get_ffree() != _struct._get_ffree())) {
			
			show_debug_message("UNIT::timer -> вероятно не верная реализация метода _clone в классе " + instanceof(self)
			+ "\n\t; экземпляр, который был клонирован: " + string(_struct)
			+ "\n\t; клон: " + string(self)
			+ "\n\t; callstack: " 
			);
			
			var _callstack = debug_get_callstack();
			var _size = array_length(_callstack);
			for (var _i = 0; _i < _size; ++_i) {
				
				show_debug_message("\n\t;" + string(_callstack[_i]));
			}
			
		}
		
		}
		
		return self;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	#region public
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		show_error("UNIT::timer -> для класса " + instanceof(self) + " не определён метод _clone", true);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	
	static _mark = function() {
		if (UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK) {
		
		var _cell = __UNIT_tmHandlerMap()[? self];
		if (_cell != undefined) {
			
			if (self.__mark_ref == undefined) {
				
				self.__mark = weak_ref_create(self);
				self.__mark_ref = _cell;
			}
		}
		return self.__mark;
		
		}
		else {
		
		show_error("UNIT::timer -> UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK отключена", true);
		
		}
	}
	
	
	static _bindCan = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		return !variable_struct_exists(self, "__");
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_BIND_SWITCH, true);
		
		}
	}
	
	static _bindEnable = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		variable_struct_remove(self, "__");
		return self;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_BIND_SWITCH, true);
		
		}
	}
	
	static _bindDisable = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		self.__ = undefined;
		return self;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_BIND_SWITCH, true);
		
		}
	}
	
	
	static _unbind = function() {
		UNIT_tmUnbind(self);
		return self;
	}
	
	#endregion
	
}

#endregion