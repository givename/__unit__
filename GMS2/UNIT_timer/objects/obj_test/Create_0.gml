

//UNIT_tmGl_loop(function() {
//	show_debug_message("loop");
//});


//exit;





/*
var _handler = new UNIT_TmHandlerSimple();
_handler.newLoop(function() {
	show_debug_message("loop");	
});

_handler._clone().newLoop();

var _timer = new UNIT_TmTimerAsync(1500, function() {
	show_debug_message("_timer");
})._bindDisable()._bindEnable();

UNIT_tmGl_timer(_timer);
UNIT_tmGl_async(1500, function() {
	show_debug_message("async");
});*/

/*
timer = new UNIT_TmTimerLoopAsync(
	function(_handler, _timer) {
		show_debug_message(_timer.name);
	},
	function() {
		
	},
	function() {
		
	},
)._set("name", "Kirill");

timer2 = timer._clone()._set("name", "Dasha");

UNIT_tmGl_timer(timer);
UNIT_tmGl_timer(timer2);

handler = UNIT_tmGl()._clone();

UNIT_tmGl().clearLoop(); */



//timer_step = UNIT_tmGl_loopAsync(function(_0, _timer, _1, _step) {
//	show_debug_message(_step);
	
//	if (keyboard_check_pressed(vk_space)) {
		
//		UNIT_tmGl_timer(timer_switch);
//		return true;
//	}
//});

//timer_switch = UNIT_tmGl_loop(function() {
//	show_debug_message("pause");
	
//	if (keyboard_check_pressed(vk_space)) {
		
//		UNIT_tmGl_timer(timer_step);
//		return true;
//	}
//})._unbind();



//timer = new UNIT_TmTimerAsyncExt(1000, 
//	function(_handler, _timer) {
//		show_debug_message(_timer.name);
//	}, undefined,
//	function(_0, _timer) {
		
//		UNIT_tmGl_timer(_timer).resetTime();
//	}
//)._set("name", "Kirill");

//timer2 = timer._clone()._set("name", "Dasha");

//UNIT_tmGl_timer(timer);
//UNIT_tmGl_timer(timer2);


UNIT_tmGl_loop(
	function(_0, _timer) {
		
		if (_timer.timer != undefined) {
			_timer.timer.unbind();
		}
		
		show_message(1);
		
		
		_timer.timer = UNIT_tmGl_loop(
			function(_0, _timer) {
				show_message(_timer.num);
			}, undefined,
			function(_0, _timer) {
				_timer.timer.unbind();
				UNIT_tmGl_loop(
					function(_0, _timer) {
						var _text = "&" + string(_timer.num);
						show_message(_text);
						if (_text == "&8") {
							
							var _t1 = UNIT_tmGl_loop();
							var _t2 = UNIT_tmGl_loop(undefined, undefined, function() { show_message(222); });
							var _t3 = UNIT_tmGl_loop(undefined, undefined, function() {
								//show_message(UNIT_tmGl().__clear);
								UNIT_tmGl().clearLoop(); });
							var _t4 = UNIT_tmGl_loop(undefined, undefined, function() { show_message(444); });
							
							
							_t2.unbind();
							_t4.unbind();
							
							UNIT_tmGl_timer(_t4);
							UNIT_tmGl_timer(_t2);
							
							var _save = self._fff;
							self._fff = undefined;
							
							UNIT_tmGl().clearLoop();
							
							show_message("clearLoop");
							show_message(_timer.isBind());
							
							UNIT_tmGl_timer(_timer);
							
							self._fff = _save;
							
							return true;
						}
					}, undefined,
					function(_0, _timer) {
						var _text = "&" + string(_timer.num);
						if (_text == "&8") {
							show_message("fff()");
							if (self._fff != undefined) {
								self._fff();
								self._fff = undefined;
							}
						}
					})._set("num", _timer.num);
			})._set("num", ++_timer.num);
		
		var _t = UNIT_tmGl_loop(
			function(_0, _timer) {
				show_message(_timer.num);
			})._set("num", ++_timer.num);
		
		_timer.timer._set("timer", _t);
		
		if (_timer.num > 8) {
			UNIT_tmGl().clear();
			return;
		}
		
	}, undefined,
	function() {
		show_message("clear");
	}
)._set("num", 1)._set("timer", undefined);

self._fff = function() {
	
	var _t;
	
	show_message("end");
	timer = UNIT_tmGl_async(5000, function(_0, _timer, _1, _count) {
		show_debug_message(["hello", _timer.getLeftCf(), _count]);
	}, undefined, function(_0, _timer) {
		show_debug_message("<< hello");
		_timer.resetTime();
		UNIT_tmGl_timer(_timer);
	});
	timer.pause();
	
	UNIT_tmGl_async(5000).unbind();
	UNIT_tmGl_async(5000).unbind();
	UNIT_tmGl_async(5000).unbind();
	
	UNIT_tmGl_endAsync(2500, function() {
		show_message("hello");
		timer.resume();
	});
	
	show_message(UNIT_tmGl().toArray());
	
	var base = UNIT_tmGl_loop(function() {
		show_debug_message("loop");	
	}).pause();
	
	UNIT_tmGl_endAsync(15000, function(_0, _timer) {
		
		_timer.t.resume();
		UNIT_tmGl().clearLoop(8);
		var _new = UNIT_tmGl_syncStp(7, 180, function(_gl, _timer) {
			show_debug_message(["sync", _timer.getTime()]);
			
		});
		show_message(_new);
		UNIT_tmGl_sync(1000 * room_speed, function() {
			show_debug_message([" >>>", "sync"]);
			return keyboard_check(vk_space);
		});
		UNIT_tmGl_async(1000 * 1000, function() {
			show_debug_message([" >>>", "async"]);
			return keyboard_check(vk_space);
		}, undefined, function() {
			UNIT_tmGl_sync(1000, undefined, undefined, function() {
				show_message("wowo");
			});
		});
	})._set("t", base);
}

