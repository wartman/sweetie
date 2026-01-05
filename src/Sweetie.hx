macro function extract(input, match) {
	return sweetie.Extract.createExtractExpr(input, match);
}

macro function as(input, type) {
	return sweetie.Type.createCast(input, type);
}

macro function pipe(...exprs) {
	return sweetie.Pipe.createPipe(exprs.toArray());
}
