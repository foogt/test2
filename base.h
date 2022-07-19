#ifndef __base__
#define __base__

#include <iostream>
#include <exception>

struct MyBase {
	static int Count;
	virtual ~MyBase() {
		Count--;
	}
	MyBase() {
		Count++;
	}
};

#endif
