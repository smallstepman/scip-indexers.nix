<?php

function hello(string $name): string {
    return "Hello, {$name}!";
}

echo hello("world"), PHP_EOL;
