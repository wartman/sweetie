# Sweetie

A little syntax sugar for Haxe.

## Usage

At the top of your file or (perhaps better) in `import.hx` add `using Sweetie`. The following extension methods will then be available:

Use `expression.extract(pattern)` to deconstruct an expression. For example:

```haxe
var something:Option<String> = Some('foo');
something.extract(try Some(foo));
trace(foo); // => "foo"
```

Note that we used `try` in the example above. This asserts that we're sure `foo` is going to yield a value and that we're OK with a potential runtime exception getting thrown if this isn't the case (if Haxe had an `assert` keyword we'd have used that here).

If we're *not* sure a value can be extracted, we have two other options. One is to give every match a default value. For example, the following code will *not* throw an exception:

```haxe
var something:Option<String> = None;
something.extract(Some(foo = 'default'));
trace(foo); // => "default"
```

You can alternatively pass an `if` expression for a little more safety. This will deconstruct an expression *only* if there is a match.

If the target expression is not matched, you can optionally provide an else branch that will be executed instead.

```haxe
var foo:Option<String> = None;
foo.extract(if (Some(value)) {
	trace(value); // does not run
} else {
	// otherwise...
	trace('Runs');
});
```
