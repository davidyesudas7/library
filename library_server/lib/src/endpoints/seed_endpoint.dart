import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SeedEndpoint extends Endpoint {
  Future<bool> seedDatabase(Session session) async {
    try {
      // Check if we already have categories
      final existingCategories = await Category.db.find(session);
      if (existingCategories.isNotEmpty) {
        return true; // Already seeded
      }

      // 1. Create Categories
      final categories = [
        Category(name: 'Art History'),
        Category(name: 'Philosophy'),
        Category(name: 'Science'),
        Category(name: 'Literature'),
        Category(name: 'Rare Manuscripts'),
        Category(name: 'Archives'),
      ];

      final insertedCategories = <String, Category>{};
      for (var cat in categories) {
        final inserted = await Category.db.insertRow(session, cat);
        insertedCategories[inserted.name] = inserted;
      }

      // 2. Create Books with images from Stitch
      final books = [
        Book(
          title: 'The Alchemy of Form',
          author: 'Thierry Beaumont',
          description: 'A weathered, antique book cover with gold-leaf typography and intricate floral patterns.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLKqO9SEkzZ3s5UjiTA6MGDBxRZly2ZcN3872FtgGR05y3rPDQH_AS2aCYUMFh_IaYDQ13HnoSMyAfe2i6jWU5rzvNp_dfhwKX8DLIA7N4HR8C9-2ktxmwUzeWN-I7xi0O-Qy2ocaWJGAR9yDjP9_XrUrRv79WMfeHgDCbKXEi1bVdO5ezuJCMuC7kMD6MMBb3FSgZizIyshYhXA54FYJrYIz_pNl4lX9FtLQtM9vYR_8GEzgmF3MUo339NhWiVqcWabu9T5HXl_g',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Art History']!.id!,
        ),
        Book(
          title: 'Metaphysical Echoes',
          author: 'Elena Rossi',
          description: 'A vintage book titled Modern Philosophy with an olive green spine.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD39Mb7swvoIaDoKnVpMPg1CzWkSBGSdVL-SPas3xsAPsFc2P2cSCGOZWR5R_Ou3zw5mDd8_17dq_S0dHZ_Q-hDtPVaTyaEYEd6mV2nGjzHUFwTglts2orOmGspkhqsULxqk2TjMrPtct2P5VKCMVHVOQOuvU32mq82S7nFchusrdSXXgFmIMZ64aqVLqTocdYCz-7KRCzWoSnhi3vScp5qSYjWBZJWX7lEVodx7zEorAjVDxGvRm7_mSkws2PVqINAv9hvBJm4WhY',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Philosophy']!.id!,
        ),
        Book(
          title: 'History of the Void',
          author: 'Archibald',
          description: 'A close-up of a dark, gothic-style book cover with embossed silver lettering.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBEXNFRG69YrhwSfSPGT5iaidfs2xS3q3We6sXWXo9PPAQvjixn9BdcDIpNZUyU3OWTJPE_H05Rpmn6ghTs7FdgTLGoYS3mYey7fdtaY9Lt8LDhIkbppLtA3JRV1Q4D12YnmGG94eE-mT12hv0zd9MKDyjtfM3KTYBdK2qW6xqrolHxBRHhV2rBO5M6KusDVoUVXb1CiV1eIjfBAaX8XCQGl_VXCFUggEvLdoNssp2Fjb6tSC8li08T_q2o9q9MR1cfNWNfVy8LyYE',
          isAvailableOnline: false,
          isAvailableOffline: true,
          categoryId: insertedCategories['Archives']!.id!,
        ),
        Book(
          title: 'Syntactic Structures',
          author: 'Noam Chomsky',
          description: 'A beautifully bound leather book with a geometric gold pattern on the cover.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC6jRFQLAm15TWObw5VlTNWZtZZWuqABwFCno4c8UjYjO8QmRMOgfXnVdwGGGjwB8M7TD1ZBEECkuppqjctawxK7AbpOJiJp4lyn8iJqh1Yx3SZPdiEREd_3_KJZooePgvrQzkUz0elHhMTQ9vTKw0wY3sxj3mwv3MJmOSuMNAqVD0iYoJGJePM2aURROuFIvak1SUGugEMi15nb8DK19AxYADuJPGe_PTv6iSVD_1N57gXieSqIopTgbQItFZwx5GIRoCd1sX16m4',
          isAvailableOnline: false,
          isAvailableOffline: true,
          categoryId: insertedCategories['Rare Manuscripts']!.id!,
        ),
        Book(
          title: 'The Ethics of Spinoza',
          author: 'Baruch Spinoza',
          description: 'An open old book with yellowed pages and elegant cursive handwriting.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAydoy6DtFVgAzr0oOcfLAs11lHSv9cRVnfjl9cq-ikBek9jmlvX2gls88GRywnSc9MzfBlp5m1FzNW6ouyX4M35wg9QUjM67p1zPw7GWaREOn4KhFwDp1OR_1o6OVXauhOylsYkjwnhvlNpKX-qlCDPh93hURftotnMYhkeMn7uOOahnXSnIRyslUl_1uKJzTNh1MpjmCDM9oQEppGJqBctCOMezkDppUWOVTcQliSklmpBlctzYivRBpwOzyKTeMdLO3EYc_vWsQ',
          isAvailableOnline: false,
          isAvailableOffline: true,
          categoryId: insertedCategories['Philosophy']!.id!,
        ),
        Book(
          title: 'The Myth of Sisyphus',
          author: 'Albert Camus',
          description: 'A collection of classic book spines lined up on a dark oak shelf.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAvCLjx7Dp4PBKRgVWc3c0TuuoMxG39zUQB6unsnoMlyY13u8gsnHBIA7e7xW_P2BWrccPkE065Fkl4MQF1t8cXaUGwZRAa0hq9dxX0Pylv2UhYxtlon0N_CZrmajnx-aHK4K0batcdrKHnZ1E_ojJGIBgByyhAmRWnUcPF_crENdJ_DjYwSZOL0jca6CAk_r1j9Dwqhztj7kcThmzTjfaGuQdaXOb5K8c-ndjHnHjRo1sC1Lpz4sL-bFKLP4Ho-ge1LXqV_zYOHG4',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Literature']!.id!,
        ),
        Book(
          title: 'Beyond Good and Evil',
          author: 'Friedrich Nietzsche',
          description: 'A single, elegant book rests on a white marble surface next to a gold bookmark.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBfiWj57YdasjTM0LHiEKpmPl0ZYlRlH1z6tZ8xgw3Nun3e6juhgOLbs5cS_1Gou_uAtBA9dWgvyezaAwdd_lvNHV6JMm7_PTCPQgkqW3mODcg9tmew7H9s8OKiu1kilR-FUWcbsNccfEFGlwinngnLgi6IfqEvwhL6w5CPXVhrFRY4aR0F7YF7xSxFO41exoKLUsuHlsULdLH1Wu26GI-StrjPa2BavYzeyi7Tu6BDZq3Y_LEVpPIkAK34kBSEctqOtkGCkMEehag',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Philosophy']!.id!,
        ),
        Book(
          title: 'The Library of Babel',
          author: 'Jorge Luis Borges',
          description: 'A close-up of aged library catalog cards with hand-typed font.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAek0kd0JPC9gNmWuYsDGzcNy6BPyter3S4fX9BBzIghXEbvbztuxAqnK8kb2MJot55K74Fobg64UqsCZKET_0e3m53KgdQMaOmvBmGN_3MNI0-29uPeFglZ9U0ftOX71SRdqLNRtYQSr_CIkYAjYnXqu9RQc9KugIp4d4kcn9KbWLGCS_pZ1TYdFwZ2yWngnRXJ1llARu5cFxT8a9emOES7k8AtXTxjoaLH0Z8DUkHMFAcvnDN6vpAe10cYFpcQfPUEN5fwAvSK1Q',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Literature']!.id!,
        ),
        Book(
          title: 'Phaedrus',
          author: 'Plato',
          description: 'An abstract composition of stacked books showing their white and cream paper edges.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAUykr4mtkf6s-IDdzGpnoGhFRvYroAl_X-GCTorDRK4vSiD-JOPEGhagsdV-KIgVQbaad23TLXTLl4EmwMSGkBcGgC_EuICD8Q6MMQAPyck2r183sdcntSOLg8bWMPam1C1szBKyeQgtHqa4DUihQ7w3T_NE3Se7cMJtm0I_4vJ2de1Q9Q_hkEXy5NCJ6Ywhwp4cqTs8CxFnHtOiYC8FF0IrG2BJcGfKOuSiUpGqYwK-bKP8_GnfeczgB0shjHM5BIRe_3sCTGPNY',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Philosophy']!.id!,
        ),
        Book(
          title: 'Meditations',
          author: 'Marcus Aurelius',
          description: 'A sleek, modern desk setup with a single glass of water and an open book.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC8VJbhuFt0Vnq6wWDUTshHrV6gVBaxAT3tMbHKagbWY-RiBYKjuWm8D-p79EeheGOmwTAPBq6-hTNZMG2gb8WsKafCWYOzfdi6Fte7YGEnmkiFUI3FKG1EPtIeChCnERRSmjHhbNmyJpPGiefCo_KSJV-mFK_mKk-LFPTyA56s9n5HK0oB_trrDB1gzwo__oPGgrVCwr_hq77f_PtaYe4Tx3y3NGeYWvpJOkaZqczkfDt244nptw4eLLrxsBOhTy99zrbyeUvUoSc',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Philosophy']!.id!,
        ),
        Book(
          title: 'The Iliad',
          author: 'Homer',
          description: 'A macro close-up of a vintage book cover for Homer\'s Iliad',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLocSd9K_uxdbe3MC9fbZTueEV8YsCy1qvLhsLU80N_p8OTgLM_8OahYz_yviFkRpEWg5PcLVI91hbF9puYw90BkuoIpuhQ4EpIJWSHCWuy-LcBrbwIOnKvGo6RD_qQw2-Jr0TCWjndWQmZBbYDWRflCgFsfN_lLqzy5k6yKZDNh0O8X3cHEPYhB5rYKlg4Yh22GVPdlSjOCfi_ZvYN_pXD00hB_oybGHwr4J-TEAtan8DgQpfVMH4auqjpHCgueB8LUCukTvs6uQ',
          isAvailableOnline: false,
          isAvailableOffline: true,
          categoryId: insertedCategories['Literature']!.id!,
        ),
        Book(
          title: 'The Republic',
          author: 'Plato',
          description: 'A minimalist and editorial book cover of Plato\'s Republic',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDy3UW8hf4apYURu505JaWoGdFYhxq7SOyjq0UK3XDBr9xNom_mawG61HhRwuBy-kYtmWxGpDcGtKd5nRZa5XwDG_IVCZGXKBS1qXu51J2vNuA_doOTfJfNdtKEQggWyI24ophzlwit8J3ttKUPUnZV1lNt1rt_3xlngK8Ouk-528f1ZgvpbC2zb7klFrF1kr3cwMq93IY4_NE__bMwma5CQbvp9B1lIFeVehNEIc3y5o-Y5H6oYws7wWiwv-seKeUOr1H7uT0RpBs',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Philosophy']!.id!,
        ),
        Book(
          title: 'Metamorphoses',
          author: 'Ovid',
          description: 'An ornate, historically inspired book cover for Ovid\'s Metamorphoses',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDY2NqfgQuUqe-h_fWoCf8EvzPBT7LlOxw45Yhg9tWicDfkZ5hWijj7e2ST-CB-VNkA3-quSbZWOsZz6_Hz-Qqx1Epy7wkOQIzfi5t9f4piarPG1-vRaLtwJqwBzgoGLknseoYFIRHnnszigCG59X1vwu-tNNFTXyCiATFnR0LLZjYh58iKzxfKay4ssW8WGVB_5baSvXvpi0WIqc5zLNen322akWVtNabM3Jr5baUoMvOfPCVLWLS4SOn64IL2b_jXx60iY9PXKrE',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Literature']!.id!,
        ),
        Book(
          title: 'The Italian Renaissance',
          author: 'Peter Burke',
          description: 'A vintage scholarly book cover for an art history volume',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBaWe1iGpcMmR8tblqL3VVK8OwWlsdxd14TUyi_vqeCcWK_kiVJYRJQbR1Nugu-R-1Ol-AHIKziaeXCquoOBQZKQLEqB9wtB37GiJrfVzUG6xmmO0qHnf_WVhBh2qYati7qh-8kubTQ2SU5rnSf8x_-b8RyKKv8GULiQN-aVv2VsloWnvmSSA_HtugsX8hCRTx5vhzQ29xfJHlRhNy3PhR1Hk5iGkjPELtlwVpDds8KEcjUXEuDh-IVbEg5rGTvkT89ijyWqHKGQMk',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Art History']!.id!,
        ),
        Book(
          title: 'Ways of Seeing',
          author: 'John Berger',
          description: 'A macro shot of a thick, cloth-bound library book spine and cover.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB7nhiVTfoPwbo8vbNW4Cel6y8B7IJ8D_tT-FIFS_nFSIFeoFxlYBFP4vo80Gdnogekp9dcGeHK-JwVNOpHuvFj5JW4jwcmaDAPZpJ8mGyMO-GnghjMLVx_VSLfSgLCq-g_EVD3z3qUEbe-64ua2LijaLdEZ3kJ6wFaHIboZbaN0niZH8TJsuezaTT5kVTmOmraVrR-JM5RnqQbOXQrmB3NLnnKG49e7abMYh8Jwv6n1Wm_x_8fC9qO6eRLuU6rg9tF7-GxYIZUJRA',
          isAvailableOnline: false,
          isAvailableOffline: true,
          categoryId: insertedCategories['Art History']!.id!,
        ),
        Book(
          title: 'Art of the Western World',
          author: 'Michael Wood',
          description: 'A modern art catalog cover featuring a bold, minimalist abstract painting.',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfVMMmaKQ9z2adIDOMCMEC4OhdYTe6MiFUSRPwkQDWLf-YzuUaKsi20hv_bikzvG3PmKs5prVkhso75UCpGTBOqkTHBUN34tEyijr2KIdC9Uf8XjnsOXE9_usi5BDnrZHnJ8L8eaIulW6TkpsGeZeHyLXNJUSZfBCdwG7vENjw1vZqwnFOoNKoYWeDXtX2F20drBA-D1N-wnx-FdlfXx70szp-Xxf2C0tDnYCdPqs7guOKXPXfi52CSIvNCl9la8SPkYQNdW7PSyQ',
          isAvailableOnline: true,
          isAvailableOffline: false,
          categoryId: insertedCategories['Art History']!.id!,
        ),
      ];

      for (var book in books) {
        await Book.db.insertRow(session, book);
      }

      return true;
    } catch (e) {
      print('Error seeding database: \$e');
      return false;
    }
  }
}
