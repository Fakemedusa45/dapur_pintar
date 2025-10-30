import os
from pathlib import Path

# Daftar semua path file yang ingin Anda buat di dalam folder 'lib'
file_paths = [
    "lib/main.dart",
    "lib/core/constants/app_colors.dart",
    "lib/core/utils/responsive.dart",
    "lib/domain/models/recipe.dart",
    "lib/infrastructure/local/hive_recipe_adapter.dart",
    "lib/infrastructure/local/recipe_local_repository.dart",
    "lib/infrastructure/remote/mock_recipe_repository.dart",
    "lib/application/providers/home_provider.dart",
    "lib/application/providers/saved_recipes_provider.dart",
    "lib/application/providers/scan_provider.dart",
    "lib/application/notifiers/home_notifier.dart",
    "lib/application/notifiers/saved_recipes_notifier.dart",
    "lib/application/notifiers/scan_notifier.dart",
    "lib/presentation/screens/home_screen.dart",
    "lib/presentation/screens/scan_screen.dart",
    "lib/presentation/screens/saved_recipes_screen.dart",
    "lib/presentation/screens/recipe_detail_screen.dart",
    "lib/presentation/widgets/recipe_card.dart",
    "lib/presentation/widgets/filter_bottom_sheet.dart",
    "lib/presentation/widgets/empty_state.dart",
    "lib/presentation/routes/app_router.dart",
]

def create_project_structure(base_dir="."):
    """
    Membuat struktur folder dan file berdasarkan daftar file_paths
    di dalam direktori dasar (base_dir).
    """
    print(f"Membuat struktur proyek di: {os.path.abspath(base_dir)}")
    
    total_files = len(file_paths)
    created_count = 0
    
    for file_path in file_paths:
        # Gabungkan direktori dasar dengan path file
        full_path = Path(base_dir) / Path(file_path)
        
        # Dapatkan direktori induk dari file
        parent_dir = full_path.parent
        
        try:
            # Buat direktori induk jika belum ada
            parent_dir.mkdir(parents=True, exist_ok=True)
            
            # Buat file kosong
            full_path.touch(exist_ok=True)
            
            print(f"[OK] Dibuat: {full_path}")
            created_count += 1
            
        except OSError as e:
            print(f"[ERROR] Gagal membuat {full_path}: {e}")

    print("\n--- Selesai ---")
    print(f"Berhasil membuat {created_count} dari {total_files} file dan direktori yang diperlukan.")

# --- Jalankan fungsi ---
if __name__ == "__main__":
    # Skrip ini akan membuat folder 'lib' di direktori
    # tempat Anda menjalankan skrip Python ini (diasumsikan 'dapur_pintar/').
    create_project_structure(".")