#include <iostream>
#include <jni.h>
#include "example.h"

using namespace std;

extern "C"
JNIEXPORT jlong JNICALL
Java_com_myapp_RNCPPCodeModule_multiply(JNIEnv *env, jclass type, jlong a, jlong b) {
    return example::multiply(a, b);
}