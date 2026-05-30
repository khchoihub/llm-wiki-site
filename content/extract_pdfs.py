import pypdf, os, sys

folder = r'G:\내 드라이브\(중요) BOOK\6 다시읽고싶은 행정학'
files = sorted([f for f in os.listdir(folder) if f.endswith('.pdf')])

batch_start = int(sys.argv[1]) if len(sys.argv) > 1 else 0
batch_end = int(sys.argv[2]) if len(sys.argv) > 2 else len(files)

for fname in files[batch_start:batch_end]:
    path = os.path.join(folder, fname)
    try:
        reader = pypdf.PdfReader(path)
        text = ''
        for page in reader.pages[:10]:
            t = page.extract_text()
            if t: text += t + '\n'
            if len(text) > 5000: break
        text = text[:5000].strip()
        print(f'=== FILE: {fname} ===')
        print(text[:2500] if text else '[텍스트 추출 실패 - 스캔본 가능성]')
        print()
    except Exception as e:
        print(f'=== FILE: {fname} ===')
        print(f'[오류: {e}]')
        print()
