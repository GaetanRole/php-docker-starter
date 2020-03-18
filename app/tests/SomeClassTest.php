<?php

declare(strict_types=1);

namespace Tests;

use App\SomeClass;
use PHPUnit\Framework\TestCase;

/**
 * This class is just here to show PHPUnit remote debugging
 * @author Gaëtan Rolé-Dubruille <gaetan.role-dubruille@sensiolabs.com>
 */
class SomeClassTest extends TestCase
{
    public function testIfGetClassNameReturnTheGoodOne(): void
    {
        self::assertSame('SomeClass', (new SomeClass())->getClassName());
    }
}
