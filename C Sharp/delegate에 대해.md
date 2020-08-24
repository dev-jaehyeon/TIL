delegate에 대해서

C++에서 비교하는데 쓰인 delegate 코드들이다. 이들은 향후 내가 회사 프로젝트에서 시도했던 '함수들의 배열'을 다시 정리하는데 써보려고 한다.

```c#
using System;

namespace CSharp
{
    class Program
    {
        public delegate void MyDelegate();

        static void Main(string[] args)
        {
            MyDelegate myDelegate = SayHello;
            myDelegate?.Invoke();
        }

        static public void SayHello()
        {
            Console.WriteLine("Hello!");
        }
    }
}

```

