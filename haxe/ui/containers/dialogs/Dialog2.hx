package haxe.ui.containers.dialogs;

import haxe.ui.backend.DialogBase;
import haxe.ui.core.UIEvent;

abstract DialogButton2(String) from String {
    public static inline var SAVE:DialogButton2 = "Save";
    public static inline var YES:DialogButton2 = "Yes";
    public static inline var NO:DialogButton2 = "No";
    public static inline var CLOSE:DialogButton2 = "Close";
    public static inline var OK:DialogButton2 = "OK";
    public static inline var CANCEL:DialogButton2 = "Cancel";
    public static inline var APPLY:DialogButton2 = "Apply";
    
    @:op(A | B)
    private static inline function bitOr(lhs:DialogButton2, rhs:DialogButton2):DialogButton2 {
        var larr = Std.string(lhs).split("|");
        var rarr = Std.string(rhs).split("|");
        for (r in rarr) {
			if (larr.indexOf(r) == -1) {
            	larr.push(r);
			}
		}
        return larr.join("|");
    }
    
    @:op(A == B)
    private static inline function eq(lhs:DialogButton2, rhs:DialogButton2):Bool {
        var larr = Std.string(lhs).split("|");
        return larr.indexOf(Std.string(rhs)) != -1;
    }
    
	public function toArray():Array<DialogButton2> {
        return Std.string(this).split("|");
    }
    
	public function toString():String {
        return Std.string(this);
    }
}

class DialogEvent extends UIEvent {
    public static inline var DIALOG_CLOSED:String = "dialogClosed";
    
    public var button:DialogButton2;
    
    public override function clone():DialogEvent {
        var c:DialogEvent = new DialogEvent(this.type);
        c.type = this.type;
        c.bubble = this.bubble; 
        c.target = this.target;
        c.data = this.data;
        c.canceled = this.canceled;
        c.button = this.button;
        postClone(c);
        return c;
    }
}

class Dialog2 extends DialogBase {
    public function new() {
        super();
    }
    
    private var __onDialogClosed:DialogEvent->Void;
    public var onDialogClosed(null, set):DialogEvent->Void;
    private function set_onDialogClosed(value:DialogEvent->Void):DialogEvent->Void {
        if (__onDialogClosed != null) {
            unregisterEvent(DialogEvent.DIALOG_CLOSED, __onClick);
            __onDialogClosed = null;
        }
        registerEvent(DialogEvent.DIALOG_CLOSED, value);
        __onDialogClosed = value;
        return value;
    }
}