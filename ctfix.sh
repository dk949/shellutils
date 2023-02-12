#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage $0 [FILE]"
    exit 1
fi

clang-tidy --checks="\
    bugprone-argument-comment,\
    bugprone-bool-pointer-implicit-conversion,\
    bugprone-implicit-widening-of-multiplication-result,\
    bugprone-macro-parentheses,\
    bugprone-misplaced-operator-in-strlen-in-alloc,\
    bugprone-misplaced-pointer-arithmetic-in-alloc,\
    bugprone-not-null-terminated-result,\
    bugprone-posix-return,\
    bugprone-redundant-branch-condition,\
    bugprone-reserved-identifier,\
    bugprone-suspicious-memset-usage,\
    bugprone-suspicious-semicolon,\
    bugprone-suspicious-string-compare,\
    bugprone-swapped-arguments,\
    bugprone-terminating-continue,\
    misc-redundant-expression,\
    misc-static-assert,\
    modernize-deprecated-headers,\
    modernize-loop-convert,\
    modernize-raw-string-literal,\
    modernize-redundant-void-arg,\
    modernize-use-auto,\
    modernize-use-bool-literals,\
    modernize-use-nullptr,\
    performance-type-promotion-in-math-fn,\
    readability-braces-around-statements,\
    readability-const-return-type,\
    readability-else-after-return,\
    readability-identifier-naming,\
    readability-inconsistent-declaration-parameter-name,\
    readability-isolate-declaration,\
    readability-non-const-parameter,\
    readability-redundant-control-flow,\
    readability-redundant-declaration,\
    readability-redundant-function-ptr-dereference"\
    -p="../build/" --fix --fix-errors --format-style=file "$1"
