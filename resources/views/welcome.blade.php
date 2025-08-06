<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>M-Inventory - Sistem Informasi Manajemen Inventaris</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="icon" type="image/png" href="{{ asset('images/favicon.png') }}" alt="favicon" class="h-[32px] w-[32px]">
    <!-- Fonts -->
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600,700&display=swap" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Tailwind -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>

<body class="bg-gray-50 text-gray-800 antialiased font-sans government-pattern">
    <div class="min-h-screen flex flex-col justify-between">

        {{-- Navbar --}}
        <nav class="bg-gray-50 flex justify-between items-center px-6 py-4 shadow-sm">
            <div class="flex items-center space-x-2">
                <x-application-logo class="h-6 w-6 text-orange-600" />
                <span class="font-bold text-lg text-gray-800">M-Inventory</span>
            </div>
            <ul class="hidden md:flex space-x-8 text-sm font-medium text-gray-600">
                <li><a href="#" class="hover:text-orange-600 transition">Tentang</a></li>
                <li><a href="#" class="hover:text-orange-600 transition">Ketersediaan Barang</a></li>
                <li><a href="#" class="hover:text-orange-600 transition">Kontak</a></li>
                <li><a href="{{ route('login') }}" class="hover:text-orange-600 transition">Login</a></li>
            </ul>
        </nav>

        {{-- Hero Section --}}
        <section class="flex flex-col-reverse md:flex-row items-center justify-between px-6 md:px-20 py-16">
            <div class="md:w-1/2 space-y-6">
                <h1 class="text-4xl md:text-5xl font-extrabold text-gray-900 leading-tight">
                    Selamat Datang di M-Inventory 🎉
                </h1>
                <p class="text-lg text-gray-600">
                    M-Inventory adalah sistem informasi manajemen barang yang dirancang untuk mempermudah proses
                    inventarisasi, peminjaman, dan pelaporan kerusakan dalam satu platform yang efisien.
                </p>
                <a href="{{ route('login') }}"
                    class="inline-block bg-orange-500 hover:bg-orange-600 text-white font-semibold px-6 py-3 rounded-lg shadow transition">
                    Masuk Sekarang →
                </a>
            </div>

            <div class="md:w-1/2 mb-10 md:mb-0">
                <img src="{{ asset('images/package-delivery.svg') }}" alt="Illustration"
                    class="w-full max-w-md mx-auto">
            </div>
        </section>

        {{-- Enhanced Stok Barang Section --}}
        <section class="px-6 py-16 bg-gray-50">
            <div class="max-w-7xl mx-auto">
                <div class="text-center mb-12">
                    <div class="flex items-center justify-center mb-4">
                        <div class="w-12 h-1 bg-orange-500 rounded-full mr-3"></div>
                        <i class="fas fa-warehouse text-3xl text-green-700"></i>
                        <div class="w-12 h-1 bg-orange-500 rounded-full ml-3"></div>
                    </div>
                    <h2 class="text-3xl font-bold text-gray-800 mb-4">Stok Barang per Gudang</h2>
                    <p class="text-lg text-gray-600">Monitor ketersediaan barang secara real-time</p>
                </div>

                {{-- Grid Gudang --}}
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    @foreach ($locations as $location)
                        <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-orange-500 card-hover">
                            <div class="flex items-center mb-4">
                                <div class="w-10 h-10 bg-gradient-to-r from-orange-400 to-orange-600 rounded-full flex items-center justify-center mr-3">
                                    <i class="fas fa-building text-white"></i>
                                </div>
                                <div>
                                    <h3 class="text-lg font-bold text-gray-800">{{ $location->name }}</h3>
                                    <p class="text-sm text-gray-500">
                                        <i class="fas fa-map-marker-alt mr-1"></i>Lokasi Gudang
                                    </p>
                                </div>
                            </div>

                            <div class="space-y-3">
                                @forelse ($location->items->take(4) as $item)
                                    <div class="flex justify-between items-center p-3 bg-gray-50 rounded-lg">
                                        <div class="flex items-center">
                                            <i class="fas fa-box text-blue-600 mr-2"></i>
                                            <span class="text-sm font-medium text-gray-700">{{ $item->name }}</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="stock-value bg-green-100 text-green-800 px-2 py-1 rounded-full text-xs font-bold">
                                                {{ $item->stock }}
                                            </span>
                                        </div>
                                    </div>
                                @empty
                                    <div class="text-center py-8 text-gray-500">
                                        <i class="fas fa-inbox text-4xl mb-2"></i>
                                        <p class="italic">Belum ada barang tercatat</p>
                                    </div>
                                @endforelse
                            </div>
                            
                            @if($location->items->count() > 4)
                                <div class="mt-4 text-center">
                                    <span class="text-xs text-gray-500">
                                        <i class="fas fa-plus-circle mr-1"></i>
                                        {{ $location->items->count() - 4 }} barang lainnya
                                    </span>
                                </div>
                            @endif
                        </div>
                    @endforeach
                </div>

                {{-- Paginate --}}
                <div class="mt-12 flex justify-center">
                    {{ $locations->onEachSide(1)->links() }}
                </div>
            </div>
        </section>

        {{-- Enhanced Artikel Section --}}
        <section class="bg-white px-6 py-16 border-t-4 border-orange-500">
            <div class="max-w-7xl mx-auto">
                <div class="text-center mb-12">
                    <div class="flex items-center justify-center mb-4">
                        <div class="w-12 h-1 bg-green-700 rounded-full mr-3"></div>
                        <i class="fas fa-newspaper text-3xl text-blue-600"></i>
                        <div class="w-12 h-1 bg-green-700 rounded-full ml-3"></div>
                    </div>
                    <h2 class="text-3xl font-bold text-gray-800 mb-4">Berita & Artikel Terbaru</h2>
                    <p class="text-lg text-gray-600">Informasi dan update terkini seputar manajemen inventaris</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    @foreach (\App\Models\Blog::latest()->take(3)->get() as $blog)
                        <article class="bg-white rounded-xl shadow-lg overflow-hidden card-hover group">
                            @if ($blog->thumbnail)
                                <div class="relative overflow-hidden">
                                    <img src="{{ asset('storage/' . $blog->thumbnail) }}" alt="{{ $blog->title }}"
                                        class="w-full h-56 object-cover group-hover:scale-105 transition-transform duration-300">
                                    <div class="absolute top-4 left-4">
                                        <span class="bg-orange-500 text-white px-3 py-1 rounded-full text-xs font-bold">
                                            <i class="fas fa-calendar-alt mr-1"></i>Terbaru
                                        </span>
                                    </div>
                                </div>
                            @else
                                <div class="h-56 bg-gradient-to-br from-orange-100 to-orange-200 flex items-center justify-center">
                                    <i class="fas fa-newspaper text-orange-400 text-6xl"></i>
                                </div>
                            @endif
                            
                            <div class="p-6">
                                <div class="flex items-center text-xs text-gray-500 mb-3">
                                    <i class="fas fa-user-circle mr-1"></i>
                                    <span class="mr-3">{{ $blog->user->name }}</span>
                                    <i class="fas fa-clock mr-1"></i>
                                    <span>{{ $blog->created_at->diffForHumans() }}</span>
                                </div>
                                
                                <h3 class="text-lg font-bold text-gray-900 mb-3 line-clamp-2 group-hover:text-orange-600 transition-colors">
                                    {{ $blog->title }}
                                </h3>
                                
                                <p class="text-gray-600 text-sm mb-4 line-clamp-3">
                                    {{ Str::limit(strip_tags($blog->content), 120) }}
                                </p>
                                
                                <a href="{{ route('blogs.show', $blog) }}" 
                                    class="inline-flex items-center text-orange-600 hover:text-orange-700 font-semibold text-sm transition">
                                    Baca Selengkapnya
                                    <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition-transform"></i>
                                </a>
                            </div>
                        </article>
                    @endforeach
                </div>
            </div>
        </section>

        {{-- Enhanced Footer --}}
        <footer class="bg-gray-800 text-white">
            <div class="max-w-7xl mx-auto px-6 py-12">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <!-- Logo & Info -->
                    <div class="col-span-1 md:col-span-2">
                        <div class="flex items-center space-x-3 mb-4">
                            <div class="flex items-center justify-center w-12 h-12 bg-orange-500 rounded-full">
                                <i class="fas fa-boxes text-white text-xl"></i>
                            </div>
                            <div>
                                <h3 class="font-bold text-xl">M-Inventory</h3>
                                <p class="text-gray-400 text-sm">Sistem Manajemen Inventaris Pemerintahan</p>
                            </div>
                        </div>
                        <p class="text-gray-300 text-sm mb-4">
                            Solusi digital terdepan untuk pengelolaan inventaris dan aset instansi pemerintahan 
                            dengan standar keamanan dan akuntabilitas tinggi.
                        </p>
                        <div class="flex space-x-4">
                            <a href="#" class="text-gray-400 hover:text-orange-400 transition">
                                <i class="fab fa-facebook text-xl"></i>
                            </a>
                            <a href="#" class="text-gray-400 hover:text-orange-400 transition">
                                <i class="fab fa-twitter text-xl"></i>
                            </a>
                            <a href="#" class="text-gray-400 hover:text-orange-400 transition">
                                <i class="fab fa-instagram text-xl"></i>
                            </a>
                            <a href="#" class="text-gray-400 hover:text-orange-400 transition">
                                <i class="fab fa-linkedin text-xl"></i>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Quick Links -->
                    <div>
                        
                    </div>
                    
                    <!-- Contact Info -->
                    <div>
                        <h4 class="font-semibold mb-4 text-orange-400">Kontak</h4>
                        <ul class="space-y-2 text-sm">
                            <li class="flex items-center text-gray-300">
                                <i class="fas fa-phone mr-2 text-orange-400"></i>
                                (021) 1500-xxx
                            </li>
                            <li class="flex items-center text-gray-300">
                                <i class="fas fa-envelope mr-2 text-orange-400"></i>
                                minventory44@gmail.com
                            </li>
                            <li class="flex items-start text-gray-300">
                                <i class="fas fa-map-marker-alt mr-2 text-orange-400 mt-1"></i>
                                <span>Jl. Paker Dawetan Dusun Paker, Paker, Mulyodadi, Kec. Bambanglipuro,<br>Kabupaten Bantul, Daerah Istimewa Yogyakarta</span>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <div class="border-t border-gray-700 mt-8 pt-8 flex flex-col md:flex-row justify-between items-center">
                    <p class="text-gray-400 text-sm">
                        &copy; {{ date('Y') }} M-Inventory. Dikembangkan untuk Instansi Pemerintahan Indonesia.
                    </p>
                    <div class="flex space-x-4 mt-4 md:mt-0">
                        <a href="#" class="text-gray-400 hover:text-white text-sm transition">Privacy Policy</a>
                        <span class="text-gray-600">|</span>
                        <a href="#" class="text-gray-400 hover:text-white text-sm transition">Terms of Service</a>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- Scripts -->
    <script src="https://js.pusher.com/7.2/pusher.min.js"></script>
    <script>
        // Pusher Config
        Pusher.logToConsole = false;

        const pusher = new Pusher('{{ config('broadcasting.connections.pusher.key') }}', {
            cluster: '{{ config('broadcasting.connections.pusher.options.cluster') }}',
            forceTLS: true
        });

        const channel = pusher.subscribe('stock-channel');

        channel.bind('item.stock.updated', function (data) {
            console.log('Stok diperbarui:', data);

            const itemEl = document.getElementById('item-' + data.item_id);
            if (itemEl) {
                const span = itemEl.querySelector('.stock-value');
                if (span) {
                    span.textContent = data.stock;
                    span.classList.add('pulse-animation');
                    setTimeout(() => span.classList.remove('pulse-animation'), 2000);
                }
            }
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Mobile menu toggle (if needed)
        const mobileMenuBtn = document.querySelector('button');
        if (mobileMenuBtn) {
            mobileMenuBtn.addEventListener('click', function() {
                // Add mobile menu functionality here
                console.log('Mobile menu clicked');
            });
        }
    </script>
</body>

</html>