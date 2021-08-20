#!/bin/sh
## Not sure if safe, but looks good
# altera-struct-pack-align
# cppcoreguidelines-init-variables
# cppcoreguidelines-pro-bounds-constant-array-index
# cppcoreguidelines-pro-type-cstyle-cast
# llvm-include-order
# misc-definitions-in-headers
# misc-unused-parameter
# modernize-use-using ## looks safe, but messes with old struct typedefs
# readability-implicit-bool-conversion
# readability-misplaced-array-index
# readability-named-parameter
# readability-simplify-boolean-expr
# readability-simplify-subscript-expr

## Pretty sure is safe but useless for C
# bugprone-copy-constructor-init
# bugprone-inaccurate-erase
# bugprone-move-forwarding-reference
# bugprone-parent-virtual-call
# bugprone-string-constructor
# bugprone-string-integer-assignment
# bugprone-unused-raii
# bugprone-virtual-near-miss
# cppcoreguidelines-prefer-member-initializer
# cppcoreguidelines-pro-type-member-init
# cppcoreguidelines-pro-type-static-cast-downcast
# google-explicit-constructor
# misc-uniqueptr-reset-release
# misc-unused-alias-decls
# misc-unused-using-decls
# modernize-avoid-bind
# modernize-concat-nested-namespaces
# modernize-deprecated-ios-base-aliases
# modernize-make-shared
# modernize-make-unique
# modernize-pass-by-value
# modernize-replace-auto-ptr
# modernize-replace-disallow-copy-and-assign-macro
# modernize-replace-random-shuffle
# modernize-return-braced-init-list
# modernize-shrink-to-fit
# modernize-unary-static-assert
# modernize-use-default-member-init
# modernize-use-emplace
# modernize-use-equals-default
# modernize-use-equals-delete
# modernize-use-nodiscard
# modernize-use-noexcept
# modernize-use-override
# modernize-use-transparent-functors
# modernize-use-uncaught-exceptions
# performance-faster-string-find,\
# performance-for-range-copy
# performance-inefficient-algorithm
# performance-inefficient-vector-operation
# performance-move-const-arg
# performance-noexcept-move-constructor
# performance-trivially-destructible
# performance-unnecessary-value-param
# readability-container-size-empty
# readability-delete-null-pointer
# readability-make-member-function-const
# readability-qualified-auto
# readability-redundant-access-specifiers
# readability-redundant-member-init
# readability-redundant-smartptr-get
# readability-redundant-string-cstr
# readability-redundant-string-init
# readability-static-accessed-through-instance
# readability-static-definition-in-anonymous-namespace
# readability-string-compare
# readability-uniqueptr-delete-release


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
