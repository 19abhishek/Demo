#include <iostream>
#include <jni.h>
#include "example.h"
#include <string>

using namespace std;

jstring toJString(JNIEnv* env, const std::string& str) {
    return env->NewStringUTF(str.c_str());
}

std::string jstring2string(JNIEnv *env, jstring jStr) {
    if (!jStr)
        return "";

    const jclass stringClass = env->GetObjectClass(jStr);
    const jmethodID getBytes = env->GetMethodID(stringClass, "getBytes", "(Ljava/lang/String;)[B");
    const jbyteArray stringJbytes = (jbyteArray) env->CallObjectMethod(jStr, getBytes, env->NewStringUTF("UTF-8"));

    size_t length = (size_t) env->GetArrayLength(stringJbytes);
    jbyte* pBytes = env->GetByteArrayElements(stringJbytes, NULL);

    std::string ret = std::string((char *)pBytes, length);
    env->ReleaseByteArrayElements(stringJbytes, pBytes, JNI_ABORT);

    env->DeleteLocalRef(stringJbytes);
    env->DeleteLocalRef(stringClass);
    return ret;
}

extern "C"
JNIEXPORT jlong JNICALL
Java_com_myapp_RNCPPCodeModule_multiply(JNIEnv *env, jclass type, jlong a, jlong b) {
    return example::multiply(a, b);
}

extern "C"
JNIEXPORT jstring JNICALL
Java_com_myapp_RNCPPCodeModule_xorString(JNIEnv *env, jclass type, jstring a, jstring b) {
    string a1 = jstring2string(env, a);
    string b1 = jstring2string(env, b);
    return toJString(env, example::xorString(a1, b1));
}

// extern "C"
// JNIEXPORT jstring JNICALL
// Java_com_myapp_RNCPPCodeModule_sha256(JNIEnv *env, jclass type, jstring a) {
//     string a1 = jstring2string(env, a);
//     return toJString(env, example::sha256(a1));
// }

extern "C"
JNIEXPORT jstring JNICALL
Java_com_myapp_RNCPPCodeModule_sha512(JNIEnv *env, jclass type, jstring a) {
    string a1 = jstring2string(env, a);
    return toJString(env, example::sha512(a1));
}