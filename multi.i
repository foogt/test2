%module multi

%{
#include <memory>
#include <iostream>
#include "base.h"
#include "derived.h"

int MyBase::Count = 0;
%}

%include <std_shared_ptr.i>

%shared_ptr(MyBase)
%shared_ptr(MyDerived)

%feature("unref") MyBase
%{
    // Swig could delete derived class shared_ptr from base class shared_ptr.
    // However swig would cast a new base shared_ptr but forgot to delete the object in (SwigPyObj*)self->ptr.
    // note: If no implicit cast between different type of shared_ptr, (shared_ptr<T>*)smartgarg1 would 
    //       point to (SwigPyObj*)self->ptr. And the object will be deleted correctly.
    std::cout << "Unref from base\n";
    delete smartarg1;
    /*
    if (smartarg1)
    {
        delete smartarg1;
    }
    else
    {
        for (
            SwigPyObject* sobj=SWIG_Python_GetSwigThis(self);
            sobj!=nullptr;
            sobj=sobj->next!=nullptr ? SWIG_Python_GetSwigThis(sobj->next) : 0)
        {
            delete reinterpret_cast<std::shared_ptr<MyBase>*>(sobj->ptr);
        }
    }
    */
%}

%include base.h
%include derived.h
