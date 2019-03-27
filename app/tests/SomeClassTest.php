<?php

namespace Tests;

use App\SomeClass;
use PHPUnit\Framework\TestCase;

/**
 * Class SomeClassTest
 * @package App\Tests
 */
class SomeClassTest extends TestCase
{
    public function testIfGetClassNameReturnTheGoodOne(): void
    {
        TestCase::assertSame('SomeClass', (new SomeClass())->getClassName());
    }
}
