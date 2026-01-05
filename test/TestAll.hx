import haxe.ds.Option;
import utest.Test;

using utest.Assert;
using Sweetie;

class TestAll extends Test {
	function testItCanDeconstructObjects() {
		var foo:{a:String, b:Int} = {a: 'a', b: 1};
		foo.extract(try {a: a, b: b});
		a.equals('a');
		b.equals(1);
	}

	function testItCanDeconstructAnEnum() {
		var foo:Option<String> = Some('foo');
		foo.extract(try Some(actual));
		actual.equals('foo');
	}

	function testItCanHandleNonMatchesWithoutAnException() {
		var foo:Option<String> = None;
		foo.extract(Some(actual = 'foo'));
		actual.equals('foo');
	}

	function testUsesIfExprAsAGuardAndReturnsTrueOnAMatch() {
		var foo:Option<String> = Some('foo');
		foo.extract(if (Some(value)) value.equals('foo'));
	}

	function testUsesIfExprAsAGuardAndReturnsFalseOnAMiss() {
		var foo:Option<String> = None;
		foo.extract(if (Some(value)) {
			value.equals('foo');
		} else {
			foo.equals(None);
		});
	}

	function testDoesNotLeakScopes() {
		var foo:Option<String> = Some('foo');
		var value:String = 'bar';
		foo.extract(if (Some(value)) value.equals('foo'));
		value.equals('bar');
	}

	function testPipeWorks() {
		function add(input:String, append:String) {
			return input + append;
		}

		var result = 'foo'.pipe(add(_, 'bar'), add('bin', _), add(_, 'bax'));
		result.equals('binfoobarbax');

		var result = 'foo'.pipe(add(_, 'bar'), str -> str + 'ok', add('ok', _));
		result.equals('okfoobarok');
	}
}
