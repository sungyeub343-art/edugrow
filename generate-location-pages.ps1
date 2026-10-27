$ErrorActionPreference = 'Stop'

$siteUrl = 'https://edugrow.kr'
$verification = '5102b73793afd2b7a181cc7610526b5c668970b5'
$googleVerification = '30EmtwePj6A4sjdlOnIHnXM_PbOWzJkuM_wnzxn-6oo'
$phone = '010-2928-3614'
$phoneTel = 'tel:01029283614'
$ogImage = 'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=1200&h=630&q=80'
$today = Get-Date -Format 'yyyy-MM-dd'
$utf8 = New-Object System.Text.UTF8Encoding($false)

$districts = @(
    [pscustomobject]@{
        Slug = 'seo-gu'; Name = '서구'; Character = '둔산권 내신부터 도안·관저권 학습까지 학생의 학교 진도와 이동 여건을 함께 살핍니다.'
        Dongs = @('boksu|복수동','doma-1|도마1동','doma-2|도마2동','jeongnim|정림동','byeon|변동','yongmun|용문동','tanbang|탄방동','dunsan-1|둔산1동','dunsan-2|둔산2동','dunsan-3|둔산3동','goejeong|괴정동','gajang|가장동','nae|내동','galma-1|갈마1동','galma-2|갈마2동','wolpyeong-1|월평1동','wolpyeong-2|월평2동','wolpyeong-3|월평3동','mannyeon|만년동','gasuwon|가수원동','doan|도안동','gwanjeo-1|관저1동','gwanjeo-2|관저2동','giseong|기성동')
    },
    [pscustomobject]@{
        Slug = 'yuseong-gu'; Name = '유성구'; Character = '노은·도안·전민·관평 등 생활권별 학교 일정과 학생의 현재 단원을 기준으로 수업을 설계합니다.'
        Dongs = @('jinjam|진잠동','hakha|학하동','sangdae|상대동','oncheon-1|온천1동','oncheon-2|온천2동','noeun-1|노은1동','noeun-2|노은2동','noeun-3|노은3동','sinseong|신성동','jeonmin|전민동','gujeuk|구즉동','gwanpyeong|관평동','wonsinheung|원신흥동')
    },
    [pscustomobject]@{
        Slug = 'jung-gu'; Name = '중구'; Character = '원도심과 문화·태평·산성 생활권의 학습 환경을 고려해 기초부터 내신 대비까지 연결합니다.'
        Dongs = @('eunhaeng-seonhwa|은행선화동','mok|목동','jungchon|중촌동','daeheung|대흥동','munchang|문창동','seokgyo|석교동','daesa|대사동','busa|부사동','yongdu|용두동','oryu|오류동','taepyeong-1|태평1동','taepyeong-2|태평2동','yucheon-1|유천1동','yucheon-2|유천2동','munhwa-1|문화1동','munhwa-2|문화2동','sanseong|산성동')
    },
    [pscustomobject]@{
        Slug = 'dong-gu'; Name = '동구'; Character = '가오·용운·가양·판암 등 생활권과 학교별 진도 차이를 확인해 필요한 단원부터 수업합니다.'
        Dongs = @('jungang|중앙동','hyo|효동','sinin|신인동','panam-1|판암1동','panam-2|판암2동','yongun|용운동','dae|대동','jayang|자양동','gayag-1|가양1동','gayag-2|가양2동','yongjeon|용전동','seongnam|성남동','hongdo|홍도동','samseong|삼성동','daecheong|대청동','sannae|산내동')
    },
    [pscustomobject]@{
        Slug = 'daedeok-gu'; Name = '대덕구'; Character = '송촌·법동권 내신과 신탄진권 학습 수요를 학생별 진도와 목표에 맞춰 세분화합니다.'
        Dongs = @('ojeong|오정동','daehwa|대화동','hoedeok|회덕동','birae|비래동','songchon|송촌동','jungni|중리동','beop-1|법1동','beop-2|법2동','sintanjin|신탄진동','seokbong|석봉동','deogam|덕암동','moksang|목상동')
    }
)

# 학년 단계별 페이지(구 단위)와 각 지역 페이지의 학년별 안내에 쓰는 데이터
$levels = @(
    [pscustomobject]@{
        Slug = 'elementary'; Short = '초등'; Eyebrow = 'ELEMENTARY MATH'
        TitleTail = '초등 수학수업·기초수학 1:1'
        Summary = '연산 정확도와 분수·소수, 도형 개념을 다지는 초등 수학수업과 혼자 하는 수학공부 습관을 함께 만듭니다.'
        Grades = @(
            '초1·초2|수 감각과 덧셈·뺄셈, 시계와 길이처럼 생활 속 수학을 손으로 익히며 기초수학의 바탕을 만듭니다.',
            '초3·초4|곱셈·나눗셈과 분수의 시작, 평면도형을 다룹니다. 계산 실수가 늘어나는 시기라 풀이 순서를 바르게 잡습니다.',
            '초5·초6|약수와 배수, 분수·소수의 연산, 비와 비율, 도형의 넓이와 부피를 정리하고 문장제를 식으로 바꾸는 연습을 합니다.',
            '예비중1|중학교 정수와 유리수, 문자와 식을 받아들일 수 있도록 초등 과정의 빈틈을 점검합니다.'
        )
        Faq = @(
            '초등 수학과외는 몇 학년부터 시작하는 것이 좋나요?|학년보다 현재 상태가 중요합니다. 연산 실수가 반복되거나 문장제를 어려워한다면 저학년이라도 초등 기초수학부터 짧게 시작하는 것을 권합니다.',
            '초등 수학수업은 선행 위주로 진행하나요?|현재 학년 개념을 먼저 확실히 이해하도록 돕고, 이해가 충분한 학생에 한해 다음 학기 내용을 미리 다룹니다.',
            '집에서 하는 수학공부도 관리해 주나요?|수업마다 학생의 집중 시간에 맞는 과제량을 정하고, 다음 수업에서 오답과 풀이 과정을 함께 확인합니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'middle'; Short = '중등'; Eyebrow = 'MIDDLE SCHOOL MATH'
        TitleTail = '중등 수학내신·기초수학 1:1'
        Summary = '학교별 시험 범위에 맞춘 중등 수학내신 대비와 흔들리는 개념을 다시 세우는 중등 기초수학 수업을 진행합니다.'
        Grades = @(
            '중1|정수와 유리수, 문자와 식, 일차방정식, 좌표평면과 그래프를 다룹니다. 첫 중학교 수학이라 개념을 말로 설명하는 연습을 함께 합니다.',
            '중2|식의 계산, 연립방정식, 일차함수, 도형의 성질과 확률을 정리하고 서술형 풀이 과정을 끝까지 쓰는 훈련을 합니다.',
            '중3|제곱근과 실수, 인수분해, 이차방정식, 이차함수, 삼각비를 다지며 고등 수학으로 이어지는 핵심 단원을 집중 관리합니다.',
            '예비고1|고등 공통수학에 바로 쓰이는 식의 계산, 방정식, 함수 개념을 중학 전 범위에서 다시 묶어 정리합니다.'
        )
        Faq = @(
            '중등 수학내신은 어떻게 대비하나요?|학교별 교과서와 시험 범위, 기출 유형을 확인한 뒤 기본 문제와 서술형 풀이를 중심으로 시험 4주 전부터 단계적으로 대비합니다.',
            '중등 기초수학이 많이 부족해도 괜찮나요?|진단으로 빈 단원을 찾아 이전 학년 개념부터 다시 채우고, 학교 진도에 뒤처지지 않도록 현재 단원과 병행합니다.',
            '중등 수학수업 시간과 횟수는 어떻게 정하나요?|학생의 학년, 현재 실력, 시험 일정에 맞춰 상담 후 주당 횟수와 수업 시간을 안내합니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'high'; Short = '고등'; Eyebrow = 'HIGH SCHOOL MATH'
        TitleTail = '수학내신·수능대비 1:1'
        Summary = '고등 수학내신과 수능대비를 학교 일정에 맞춰 연결하고, 수능수학에 필요한 개념 연결과 문제 해석력을 훈련합니다.'
        Grades = @(
            '고1|고등 공통수학과 첫 내신을 준비합니다. 중학 과정과 달라진 문제 길이와 난도에 적응하도록 개념 정리와 풀이 습관을 함께 잡습니다.',
            '고2|선택 과목의 개념과 학교 수학내신을 관리하면서, 수능수학으로 이어지는 단원을 미리 연결해 둡니다.',
            '고3|수능수학 실전 대비와 마지막 내신을 함께 관리하고, 목표 등급에 맞춰 취약 단원과 문제 풀이 시간을 조정합니다.',
            '수능대비|기출 분석, 취약 단원 보완, 시간 배분 훈련을 통해 시험장에서 쓸 수 있는 풀이 순서를 만듭니다.'
        )
        Faq = @(
            '고등 수학과외는 내신과 수능대비 중 무엇에 집중하나요?|학교 시험 기간에는 수학내신을, 그 외 기간에는 수능수학 개념과 기출 해석을 중심으로 진행해 두 가지를 함께 준비합니다.',
            '고등 기초수학이 부족한 학생도 수업할 수 있나요?|네. 중학 과정과 공통수학의 핵심 개념부터 다시 세운 뒤 현재 학년 진도로 연결합니다.',
            '고3 수능수학은 언제부터 준비하면 좋나요?|개념 학습은 고2 겨울방학 전까지 마무리하는 것을 권하며, 상담 시 현재 성적에 맞춰 남은 기간의 계획을 함께 세웁니다.'
        )
    }
)

function Write-Utf8File([string]$Path, [string]$Content) {
    $directory = Split-Path -Parent $Path
    if (-not (Test-Path $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $utf8)
}

function ConvertTo-JsonLd($Data) {
    $json = $Data | ConvertTo-Json -Depth 10 -Compress
    return "  <script type=`"application/ld+json`">$json</script>`n"
}

function Get-BreadcrumbLd([object[]]$Items) {
    $position = 0
    $list = foreach ($item in $Items) {
        $position++
        [ordered]@{ '@type' = 'ListItem'; position = $position; name = $item[0]; item = $item[1] }
    }
    return ConvertTo-JsonLd ([ordered]@{ '@context' = 'https://schema.org'; '@type' = 'BreadcrumbList'; itemListElement = @($list) })
}

function Get-FaqLd([string[]]$Faq) {
    $questions = foreach ($entry in $Faq) {
        $parts = $entry.Split('|')
        [ordered]@{ '@type' = 'Question'; name = $parts[0]; acceptedAnswer = [ordered]@{ '@type' = 'Answer'; text = $parts[1] } }
    }
    return ConvertTo-JsonLd ([ordered]@{ '@context' = 'https://schema.org'; '@type' = 'FAQPage'; mainEntity = @($questions) })
}

function Get-Head([string]$Title, [string]$Description, [string]$Canonical, [string]$StylePath, [string]$JsonLd) {
    return @"
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$Title</title>
  <meta name="description" content="$Description">
  <meta name="naver-site-verification" content="$verification">
  <meta name="google-site-verification" content="$googleVerification">
  <meta name="theme-color" content="#17352b">
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="대전 수학과외">
  <meta property="og:locale" content="ko_KR">
  <meta property="og:title" content="$Title">
  <meta property="og:description" content="$Description">
  <meta property="og:url" content="$Canonical">
  <meta property="og:image" content="$ogImage">
  <meta name="twitter:card" content="summary_large_image">
  <link rel="canonical" href="$Canonical">
  <link rel="icon" href="/favicon.ico" sizes="any">
  <link rel="icon" href="/logo.svg" type="image/svg+xml">
  <link rel="alternate" type="application/rss+xml" title="대전 수학과외" href="$siteUrl/rss.xml">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&family=Pretendard:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="$StylePath">
$JsonLd
"@
}

function Get-Header([string]$HomePath) {
    return @"
  <a class="skip-link" href="#main">본문으로 바로가기</a>
  <header class="site-header" id="top">
    <a class="brand" href="$HomePath" aria-label="대전 수학과외 홈"><span class="brand-mark" aria-hidden="true">∑</span><span>대전 수학과외</span></a>
    <nav class="desktop-nav" aria-label="주요 메뉴"><a href="$HomePath#approach">수업 방식</a><a href="$HomePath#program">학년별 수업</a><a href="$HomePath#area">수업 지역</a></nav>
    <a class="header-cta" href="$phoneTel" aria-label="$($phone)로 전화 상담">전화 상담</a>
  </header>
"@
}

function Get-GradeGuide([string]$AreaName) {
    return @"
      <section class="grade-guide" aria-labelledby="grade-title">
        <p class="section-number">GRADE TRANSITION</p>
        <h2 id="grade-title">학년이 바뀌기 전,<br>이어질 개념을 준비합니다</h2>
        <div class="grade-grid">
          <article><h3>예비중1 · 예비중2 · 예비중3</h3><p>$AreaName 예비중1은 초등 연산과 문장제의 빈틈을 확인하고, 예비중2와 예비중3은 다음 학년 과정에 이어지는 방정식·함수·도형 개념을 정리합니다.</p></article>
          <article><h3>예비고1</h3><p>$AreaName 예비고1은 중학 수학 전 범위에서 고등 과정의 바탕이 되는 식의 계산, 함수, 도형을 우선 점검합니다.</p></article>
          <article><h3>예비고2 · 예비고3</h3><p>$AreaName 예비고2와 예비고3은 학교별 진도와 선택 과목, 내신·수능 목표를 함께 살펴 학습 순서를 구체화합니다.</p></article>
        </div>
      </section>
"@
}

# 지역 페이지의 초등·중등·고등 수학 안내. $LevelPath는 구 단위 학년 페이지가 있는 경로
function Get-LevelSection([string]$AreaName, [string]$DistrictName, [string]$LevelPath) {
    return @"
      <section class="grade-guide" aria-labelledby="level-title">
        <p class="section-number">ELEMENTARY · MIDDLE · HIGH</p>
        <h2 id="level-title">$AreaName 초등·중등·고등<br>수학수업 안내</h2>
        <div class="grade-grid">
          <article><h3>$AreaName 초등 수학</h3><p>초등 수학수업은 연산 정확도와 분수·소수, 도형 개념을 먼저 다집니다. 문장제를 식으로 바꾸는 연습과 초등 기초수학 점검으로 집에서도 이어지는 수학공부 습관을 만듭니다.</p><a class="more-link" href="${LevelPath}elementary/">$DistrictName 초등수학 과외 보기 →</a></article>
          <article><h3>$AreaName 중등 수학</h3><p>중등 수학수업은 학교별 시험 범위에 맞춘 중등 수학내신 대비가 중심입니다. 개념이 흔들리는 학생은 중등 기초수학부터 다시 정리하고 서술형 풀이까지 연결합니다.</p><a class="more-link" href="${LevelPath}middle/">$DistrictName 중등수학 과외 보기 →</a></article>
          <article><h3>$AreaName 고등 수학</h3><p>고등 수학수업은 학교 수학내신과 수능대비를 함께 설계합니다. 고등 기초수학이 부족하면 핵심 개념부터 세우고, 수능수학 기출 해석과 시간 배분까지 훈련합니다.</p><a class="more-link" href="${LevelPath}high/">$DistrictName 고등수학 과외 보기 →</a></article>
        </div>
      </section>
"@
}

function Get-AreaFaq([string]$AreaName) {
    return @(
        "$AreaName 수학과외는 어떤 학년까지 수업하나요?|초등학생부터 중1·중2·중3, 고1·고2·고3까지 수업합니다. 예비중1, 예비고1처럼 학년이 바뀌는 시기의 복습과 선행도 상담 후 계획합니다.",
        "수학 기초가 부족해도 수업할 수 있나요?|네. 초등·중등·고등 모두 기초수학이 필요한 학생은 현재 학년 진도와 함께 비어 있는 개념을 먼저 채우는 방식으로 진행합니다.",
        "수학내신과 수능대비를 함께 할 수 있나요?|중등은 수학내신 중심으로, 고등은 학교 시험 기간에는 내신을, 그 외 기간에는 수능수학 개념과 기출 해석을 함께 준비합니다.",
        "$AreaName 대면 수업이 가능한가요?|학생의 위치와 희망 시간에 따라 대면 수업 가능 여부를 안내하며, 온라인 수업도 협의할 수 있습니다. $($phone)로 전화 주시면 바로 상담해 드립니다."
    )
}

function Get-FaqSection([string]$Heading, [string[]]$Faq) {
    $items = foreach ($entry in $Faq) {
        $parts = $entry.Split('|')
        "          <details><summary><span>$($parts[0])</span><span aria-hidden=`"true`">+</span></summary><p>$($parts[1])</p></details>"
    }
    return @"
      <section class="faq" aria-labelledby="faq-title">
        <p class="section-number">FAQ</p>
        <h2 id="faq-title">$Heading</h2>
        <div class="faq-list">
$($items -join "`n")
        </div>
      </section>
"@
}

function Get-Cta([string]$Heading) {
    return "      <section class=`"location-cta`"><div><p class=`"section-number`">CONTACT</p><h2>$Heading</h2></div><a class=`"button`" href=`"$phoneTel`" aria-label=`"$($phone)로 전화 상담`">$phone 전화 상담</a></section>"
}

function Get-Footer([string]$HomePath) {
    return @"
  <footer>
    <a class="brand footer-brand" href="$HomePath"><span class="brand-mark" aria-hidden="true">∑</span><span>대전 수학과외</span></a>
    <p>학생의 이해에서 시작하는 1:1 맞춤 수업 · 대전 서구·유성구·중구·동구·대덕구 · 전화 <a href="$phoneTel">$phone</a></p>
    <nav class="footer-links" aria-label="수학과외 가이드"><a href="${HomePath}guide/cost/">수학과외 비용</a><a href="${HomePath}guide/academy-vs-tutoring/">수학학원 vs 1:1 과외</a><a href="${HomePath}guide/choose-tutor/">과외 선생님 고르는 법</a><a href="${HomePath}guide/middle-school-grades/">중학교 수학 내신</a><a href="${HomePath}guide/high-school-grades/">고등 수학 내신 5등급제</a><a href="${HomePath}guide/school-district/">대전 학군지 수학</a><a href="${HomePath}school/">학교별 수학과외</a></nav>
    <p class="copyright">© 2026 대전 수학과외</p>
  </footer>
"@
}

# 번호로 나뉜 행정동을 사람들이 실제로 검색하는 생활권 이름(둔산동, 관저동 등)으로 묶은 페이지
$hubs = @{
    'seo-gu' = @(
        'dunsan|둔산동|dunsan-1,dunsan-2,dunsan-3|대전시청과 정부대전청사가 자리한 둔산동은 학원가가 밀집해 학교별 내신 경쟁이 치열한 편이라, 학교 프린트와 기출 유형까지 반영한 내신 대비가 중요합니다.',
        'gwanjeo|관저동|gwanjeo-1,gwanjeo-2|서구 남서쪽의 대규모 주거 단지인 관저동은 초등부터 고등까지 학생 연령대가 넓어, 학년별로 수업 목표를 분명히 나누는 것이 중요합니다.',
        'wolpyeong|월평동|wolpyeong-1,wolpyeong-2,wolpyeong-3|',
        'galma|갈마동|galma-1,galma-2|',
        'doma|도마동|doma-1,doma-2|'
    )
    'yuseong-gu' = @(
        'noeun|노은동|noeun-1,noeun-2,noeun-3|지하철 노은역 주변으로 주거 단지가 모여 있는 노은동은 학교마다 진도와 시험 일정이 달라, 학교 일정에 맞춘 내신 대비 계획이 필요합니다.',
        'oncheon|온천동|oncheon-1,oncheon-2|'
    )
    'jung-gu' = @(
        'taepyeong|태평동|taepyeong-1,taepyeong-2|',
        'munhwa|문화동|munhwa-1,munhwa-2|',
        'yucheon|유천동|yucheon-1,yucheon-2|'
    )
    'dong-gu' = @(
        'gayang|가양동|gayag-1,gayag-2|',
        'panam|판암동|panam-1,panam-2|'
    )
    'daedeok-gu' = @(
        'beop|법동|beop-1,beop-2|'
    )
}

$guideLinksHtml = @"
      <section class="local-list" aria-labelledby="guide-title"><p class="section-number">GUIDE</p><h2 id="guide-title">수학과외 전에 읽어보세요</h2><div class="area-links">
        <a href="../../../guide/cost/"><span>대전 수학과외 비용 기준</span><span aria-hidden="true">→</span></a>
        <a href="../../../guide/academy-vs-tutoring/"><span>수학학원 vs 1:1 과외</span><span aria-hidden="true">→</span></a>
        <a href="../../../guide/choose-tutor/"><span>과외 선생님 고르는 법</span><span aria-hidden="true">→</span></a>
        <a href="../../../guide/middle-school-grades/"><span>대전 중학교 수학 내신</span><span aria-hidden="true">→</span></a>
        <a href="../../../guide/high-school-grades/"><span>고등 수학 내신 5등급제</span><span aria-hidden="true">→</span></a>
        <a href="../../../guide/school-district/"><span>대전 학군지 수학 공부</span><span aria-hidden="true">→</span></a></div></section>
"@

# 학교 목록: 전국초중등학교위치표준데이터(2026-10-26)에서 대전 운영 학교를 추린 것. dong은 지번 주소의 법정동,
# nearSame/nearFeeder는 좌표 기준으로 가까운 같은 학교급/아래 학교급 학교 id
$schoolData = [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot 'data\daejeon-schools.json'), $utf8) | ConvertFrom-Json
$levelLabels = [ordered]@{ elementary = '초등학교'; middle = '중학교'; high = '고등학교' }

function Get-Schools([string]$DistrictSlug, [string]$Level, [string]$Dong) {
    $list = @($schoolData | Where-Object { $_.district -eq $DistrictSlug -and $_.level -eq $Level })
    if ($Dong) { $list = @($list | Where-Object { $_.dong -eq $Dong }) }
    return $list
}

# 법정동 이름으로 학교를 찾는다. 둔산1동처럼 번호가 붙은 행정동은 번호를 뺀 법정동(둔산동)으로 찾는다
function Get-LegalDong([string]$DongName) {
    return ($DongName -replace '\d+동$', '동')
}

# 중·고등학교는 학교별 페이지가 있으므로 링크로, 초등학교는 이름만 보여 준다
function Get-SchoolItem($School, [string]$HomePath) {
    if ($School.level -eq 'elementary') { return "<li>$($School.name)</li>" }
    return "<li><a href=`"${HomePath}school/$($School.id)/`">$($School.name)</a></li>"
}

function Get-SchoolSection([string]$AreaLabel, [string]$DistrictSlug, [string[]]$Levels, [string]$Dong, [string]$HomePath) {
    $groups = foreach ($level in $Levels) {
        $schools = Get-Schools $DistrictSlug $level $Dong
        if ($schools.Count -eq 0) { continue }
        $items = ($schools | ForEach-Object { Get-SchoolItem $_ $HomePath }) -join ''
        "          <div class=`"school-group`"><h3>$AreaLabel $($levelLabels[$level]) 수학과외 <span>$($schools.Count)곳</span></h3><ul class=`"school-list`">$items</ul></div>"
    }
    if (-not $groups) { return '' }
    $levelText = ($Levels | ForEach-Object { $levelLabels[$_] }) -join '·'
    return @"
      <section class="school-guide" aria-labelledby="school-title">
        <p class="section-number">LOCAL SCHOOLS</p>
        <h2 id="school-title">$AreaLabel $levelText<br>학교별 수학 내신 대비</h2>
        <p class="school-intro">$AreaLabel 지역 $levelText 학생의 교과서, 시험 범위, 학교 프린트와 기출 유형을 확인해 학교별로 수학 내신을 대비합니다. 아래 학교에 다니는 학생이라면 학교 일정에 맞춘 1:1 수업 계획을 안내해 드립니다.</p>
$($groups -join "`n")
        <p class="school-source">학교 목록 출처: 전국초중등학교위치표준데이터(2026년 10월 기준). 지번 주소의 법정동 기준으로 정리했습니다.</p>
      </section>
"@
}

# 수학학원·공부방 검색 수요가 확인된 동에 붙이는 안내 문단
$dongNotes = @{
    'gwanpyeong' = '관평동에서 수학학원, 교습소, 공부방을 함께 알아보는 학부모가 많습니다. 학원 차량이나 반 편성보다 우리 아이가 수업 중에 질문을 하는지, 기초에 빈틈이 있는지를 먼저 보면 학원과 1:1 과외 중 무엇이 맞을지 판단하기 쉽습니다.'
    'doan' = '도안동에서 수학학원이나 공부방을 찾고 있다면, 학생이 다니는 학교의 진도와 시험 범위에 맞춰 수업할 수 있는지부터 확인해 보세요. 1:1 수학과외는 학생 한 명의 시험지와 교재를 기준으로 진도를 정합니다.'
    'jeonmin' = '전민동에서 수학학원을 알아보는 중이라면, 반 진도를 따라가는 수업이 맞는지 학생 한 명에게 맞춘 1:1 수업이 맞는지 먼저 따져 보세요. 기초 빈틈이 있거나 질문을 어려워하는 학생은 1:1 수업이 효과적입니다.'
    'songchon' = '송촌동에서 수학학원과 과외를 비교하고 있다면, 학교별 내신 대비가 학생이 다니는 학교 기준으로 이루어지는지 확인해 보세요. 1:1 수학과외는 교과서와 학교 프린트, 기출 유형을 반영해 준비합니다.'
}

$pages = New-Object System.Collections.Generic.List[object]
$pages.Add([pscustomobject]@{ Url = "$siteUrl/"; Title = '대전 수학과외 | 초등·중등·고등 1:1 수학수업, 내신·수능대비'; Description = '대전 초중고 1:1 맞춤 수학과외. 초등 기초수학·수학공부 습관, 중등 수학내신, 고등 수능대비·수능수학까지 진단 후 학생별 계획으로 수업합니다. 전화 상담 010-2928-3614' })

foreach ($district in $districts) {
    $districtUrl = "$siteUrl/areas/$($district.Slug)/"
    $districtArea = "대전 $($district.Name)"
    $dongLinks = New-Object System.Collections.Generic.List[string]
    $districtIndex = $pages.Count
    $dongNames = @{}
    foreach ($dongEntry in $district.Dongs) { $parts = $dongEntry.Split('|'); $dongNames[$parts[0]] = $parts[1] }
    $districtHubs = @($hubs[$district.Slug] | ForEach-Object {
        $hubParts = $_.Split('|')
        [pscustomobject]@{ Slug = $hubParts[0]; Name = $hubParts[1]; Dongs = $hubParts[2].Split(','); Note = $hubParts[3] }
    })
    $dongToHub = @{}
    foreach ($hub in $districtHubs) { foreach ($sub in $hub.Dongs) { $dongToHub[$sub] = $hub } }

    foreach ($dongEntry in $district.Dongs) {
        $parts = $dongEntry.Split('|')
        $dongSlug = $parts[0]
        $dongName = $parts[1]
        $dongLinks.Add("        <a href=`"$dongSlug/`"><span>$dongName 수학과외</span><span aria-hidden=`"true`">→</span></a>")
        $dongUrl = "$districtUrl$dongSlug/"
        $nearbyLinks = @($district.Dongs | Where-Object { $_ -ne $dongEntry } | Select-Object -First 7 | ForEach-Object {
            $nearParts = $_.Split('|')
            "        <a href=`"../$($nearParts[0])/`"><span>$($nearParts[1]) 수학과외</span><span aria-hidden=`"true`">→</span></a>"
        })
        if ($dongToHub.ContainsKey($dongSlug)) {
            $parentHub = $dongToHub[$dongSlug]
            $nearbyLinks = @("        <a href=`"../$($parentHub.Slug)/`"><span>$($parentHub.Name) 전체 수학과외</span><span aria-hidden=`"true`">→</span></a>") + $nearbyLinks
        }
        $dongTitle = "$dongName 수학과외 | 초등·중등·고등 1:1 수학 ($districtArea)"
        $dongNote = ''
        if ($dongNotes.ContainsKey($dongSlug)) {
            $dongNote = "<p>$($dongNotes[$dongSlug]) 판단 기준은 <a class=`"more-link`" href=`"../../../guide/academy-vs-tutoring/`">수학학원 vs 1:1 과외 비교</a>에 정리해 두었습니다.</p>"
            $dongTitle = "$dongName 수학과외 | 학원·공부방 대신 1:1 초중고 수학 ($districtArea)"
        }
        $dongDescription = "$districtArea $dongName 수학과외. 초등 기초수학, 중등 수학내신, 고등 수능대비까지 학생 진도에 맞춘 1:1 수학수업. 전화 상담 $phone"
        $dongFaq = Get-AreaFaq $dongName
        $dongLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @("$districtArea 수학과외", $districtUrl), @("$dongName 수학과외", $dongUrl))) + (Get-FaqLd $dongFaq)
        $dongHead = Get-Head $dongTitle $dongDescription $dongUrl '../../../styles.css' $dongLd
        $dongHeader = Get-Header '../../../'
        $dongLevels = Get-LevelSection $dongName $district.Name '../'
        $legalDong = Get-LegalDong $dongName
        $dongSchools = Get-SchoolSection $legalDong $district.Slug @('elementary','middle','high') $legalDong '../../../'
        $dongGradeGuide = Get-GradeGuide "$($district.Name) $dongName"
        $dongFaqSection = Get-FaqSection "$dongName 수학과외 자주 묻는 질문" $dongFaq
        $dongCta = Get-Cta "$dongName 수학과외 상담"
        $dongFooter = Get-Footer '../../../'
        $dongHtml = @"
<!doctype html>
<html lang="ko">
<head>
$dongHead</head>
<body class="location-page">
$dongHeader
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../../../">대전</a><span>/</span><a href="../">$($district.Name)</a><span>/</span><strong>$dongName</strong></nav>
      <p class="eyebrow">DAEJEON · $($district.Name) · $dongName</p>
      <h1>$dongName 수학과외</h1>
      <p>$($dongName)에서 초등 기초수학부터 중등 수학내신, 고등 수능대비까지 학생의 이해 속도에 맞춰 1:1 수학수업 방향을 정합니다.</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">LOCAL TUTORING</p><h2 id="intro-title">가까운 곳에서<br>꾸준히 배우는 수학</h2></div>
        <div class="location-intro-copy">$dongNote<p>$($district.Character)</p><p>$dongName 수학과외는 현재 사용하는 교재와 최근 시험 결과를 먼저 살펴봅니다. 정답 개수만 확인하지 않고 개념 이해, 풀이 순서, 계산 습관 중 어디에서 막혔는지 구분해 다음 학습량을 정합니다.</p><p>초등학생, 중1·중2·중3, 고1·고2·고3 등 학년별로 필요한 목표가 다르기 때문에 $dongName 초등수학, 중등수학, 고등수학 수업은 상담에서 학년과 목표를 확인한 뒤 계획합니다.</p><p>대면 수업 가능 여부와 시간은 학생의 학년, $dongName 내 위치, 희망 일정에 따라 상담 후 안내합니다. 온라인 수업도 학습 상황에 맞춰 협의할 수 있습니다.</p></div>
      </section>
$dongLevels
$dongSchools
$dongGradeGuide
$dongFaqSection
      <section class="local-list" aria-labelledby="nearby-title"><p class="section-number">NEARBY AREA</p><h2 id="nearby-title">$($district.Name) 다른 지역 수학과외</h2><div class="area-links">$($nearbyLinks -join "`n")</div></section>
$dongCta
    </div>
  </main>
$dongFooter</body>
</html>
"@
        Write-Utf8File (Join-Path $PSScriptRoot "areas\$($district.Slug)\$dongSlug\index.html") $dongHtml
        $pages.Add([pscustomobject]@{ Url = $dongUrl; Title = $dongTitle; Description = $dongDescription })
    }

    $hubLinks = New-Object System.Collections.Generic.List[string]
    foreach ($hub in $districtHubs) {
        $hubName = $hub.Name
        $hubBase = $hubName.Substring(0, $hubName.Length - 1)
        $subNames = @($hub.Dongs | ForEach-Object { $dongNames[$_] })
        $subNumbers = @($subNames | ForEach-Object { $_.Substring($hubBase.Length, $_.Length - $hubBase.Length - 1) })
        $hubShort = "$hubBase$($subNumbers -join '·')동"
        $hubUrl = "$districtUrl$($hub.Slug)/"
        $hubLinks.Add("        <a href=`"$($hub.Slug)/`"><span>$hubName 수학과외 ($hubShort)</span><span aria-hidden=`"true`">→</span></a>")
        $hubTitle = "$hubName 수학과외 | $hubShort 초중고 1:1 수학 ($districtArea)"
        $hubDescription = "$districtArea $hubName($hubShort) 수학과외. 학원·공부방 대신 1:1로 초등 기초수학, 중등 수학내신, 고등 수능대비까지 학생 진도에 맞춰 수업합니다. 전화 상담 $phone"
        $hubFaq = @(
            "$hubName 수학과외는 $hubShort 모두 수업하나요?|네. $($subNames -join ', ') 모두 상담할 수 있으며, 학생의 위치와 희망 시간에 따라 대면 수업 가능 여부를 안내합니다. 온라인 수업도 협의할 수 있습니다.",
            "$hubName 수학학원이나 공부방과 무엇이 다른가요?|학원과 공부방은 여러 학생이 같은 진도로 수업하는 경우가 많습니다. 1:1 수학과외는 학생 한 명의 시험지와 교재를 기준으로 진도와 설명 방식, 과제량을 정합니다.",
            "$hubName 학교 내신 대비도 하나요?|학생이 다니는 학교의 교과서, 시험 범위, 기출 유형을 확인해 중등 수학내신과 고등 수학내신을 대비합니다.",
            "상담은 어떻게 받나요?|$($phone)로 전화 주시면 학생의 학년과 현재 상황을 듣고 수업 방향을 안내해 드립니다."
        )
        $hubLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @("$districtArea 수학과외", $districtUrl), @("$hubName 수학과외", $hubUrl))) + (Get-FaqLd $hubFaq)
        $hubHead = Get-Head $hubTitle $hubDescription $hubUrl '../../../styles.css' $hubLd
        $hubHeader = Get-Header '../../../'
        $hubLevels = Get-LevelSection $hubName $district.Name '../'
        $hubSchools = Get-SchoolSection $hubName $district.Slug @('elementary','middle','high') $hubName '../../../'
        $hubSubLinks = $hub.Dongs | ForEach-Object { "        <a href=`"../$_/`"><span>$($dongNames[$_]) 수학과외</span><span aria-hidden=`"true`">→</span></a>" }
        $otherHubLinks = @($districtHubs | Where-Object { $_.Slug -ne $hub.Slug } | ForEach-Object { "        <a href=`"../$($_.Slug)/`"><span>$($_.Name) 수학과외</span><span aria-hidden=`"true`">→</span></a>" })
        $otherHubLinks += "        <a href=`"../`"><span>$districtArea 수학과외</span><span aria-hidden=`"true`">→</span></a>"
        $hubNote = if ($hub.Note) { "<p>$($hub.Note)</p>" } else { '' }
        $hubFaqSection = Get-FaqSection "$hubName 수학과외 자주 묻는 질문" $hubFaq
        $hubCta = Get-Cta "$hubName 수학과외 상담"
        $hubFooter = Get-Footer '../../../'
        $hubHtml = @"
<!doctype html>
<html lang="ko">
<head>
$hubHead</head>
<body class="location-page">
$hubHeader
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../../../">대전</a><span>/</span><a href="../">$($district.Name)</a><span>/</span><strong>$hubName</strong></nav>
      <p class="eyebrow">DAEJEON · $($district.Name) · $hubShort</p>
      <h1>$hubName 수학과외</h1>
      <p>$($subNames -join '·') 어디에 살든, 학생 한 명의 시험지와 교재를 기준으로 초등·중등·고등 1:1 수학수업을 설계합니다.</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">LOCAL TUTORING</p><h2 id="intro-title">$($hubName)에서<br>1:1로 배우는 수학</h2></div>
        <div class="location-intro-copy">$hubNote<p>$($district.Character)</p><p>$hubName 수학과외는 최근 시험지와 교재로 현재 실력을 진단한 뒤, 다니는 학교의 시험 범위와 진도에 맞춰 수업 계획을 세웁니다. 정답 개수보다 개념 이해, 풀이 순서, 계산 습관 중 어디에서 막혔는지를 먼저 구분합니다.</p><p>$hubName 수학학원, 공부방, 교습소와 1:1 과외 사이에서 고민된다면 학생이 수업 중에 질문을 잘 하는지, 기초에 빈틈이 있는지부터 확인해 보세요. 판단 기준은 <a class="more-link" href="../../../guide/academy-vs-tutoring/">수학학원 vs 1:1 과외 비교</a>에 정리해 두었습니다.</p></div>
      </section>
$hubLevels
$hubSchools
$hubFaqSection
      <section class="local-list" aria-labelledby="sub-title"><p class="section-number">$($hub.Dongs.Count) AREAS</p><h2 id="sub-title">$hubName 세부 지역</h2><div class="area-links">$($hubSubLinks -join "`n")</div></section>
      <section class="local-list" aria-labelledby="nearby-title"><p class="section-number">NEARBY AREA</p><h2 id="nearby-title">$($district.Name) 다른 생활권</h2><div class="area-links">$($otherHubLinks -join "`n")</div></section>
$guideLinksHtml
$hubCta
    </div>
  </main>
$hubFooter</body>
</html>
"@
        Write-Utf8File (Join-Path $PSScriptRoot "areas\$($district.Slug)\$($hub.Slug)\index.html") $hubHtml
        $pages.Add([pscustomobject]@{ Url = $hubUrl; Title = $hubTitle; Description = $hubDescription })
    }

    $districtTitle = "$districtArea 수학과외 | 초등·중등·고등 수학수업, 내신·수능대비"
    $districtDescription = "$districtArea 초중고 1:1 수학과외. 초등 기초수학과 수학공부 습관, 중등 수학내신, 고등 수능수학까지 학생별 진단으로 수업합니다. 전화 상담 $phone"
    $districtFaq = Get-AreaFaq $districtArea
    $districtLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @("$districtArea 수학과외", $districtUrl))) + (Get-FaqLd $districtFaq)
    $districtHead = Get-Head $districtTitle $districtDescription $districtUrl '../../styles.css' $districtLd
    $districtHeader = Get-Header '../../'
    $districtLevels = Get-LevelSection $districtArea $district.Name ''
    $districtSchools = Get-SchoolSection $districtArea $district.Slug @('elementary','middle','high') '' '../../'
    $districtGradeGuide = Get-GradeGuide $districtArea
    $districtFaqSection = Get-FaqSection "$districtArea 수학과외 자주 묻는 질문" $districtFaq
    $districtCta = Get-Cta "$districtArea 수학과외 상담"
    $districtFooter = Get-Footer '../../'
    $districtHtml = @"
<!doctype html>
<html lang="ko">
<head>
$districtHead</head>
<body class="location-page">
$districtHeader
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../../">대전</a><span>/</span><strong>$($district.Name)</strong></nav>
      <p class="eyebrow">DAEJEON · $($district.Name)</p>
      <h1>$districtArea<br>수학과외</h1>
      <p>$($district.Character)</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">LOCAL TUTORING</p><h2 id="intro-title">학교 진도와<br>학생의 속도를 함께</h2></div>
        <div class="location-intro-copy"><p>$districtArea 수학과외는 최근 시험지와 교재, 평소 학습 시간을 확인하는 진단에서 시작합니다. 같은 학년이라도 개념의 빈틈과 목표가 다르기 때문에 설명 방식과 과제량을 학생별로 조정합니다.</p><p>초등 수학의 개념과 연산, 중등 수학내신의 서술형 풀이, 고등 수학의 개념 연결과 수능대비까지 현재 필요한 단계에 집중합니다.</p></div>
      </section>
$districtLevels
$districtSchools
$districtGradeGuide
$districtFaqSection
      <section class="local-list" aria-labelledby="hub-title"><p class="section-number">NEIGHBORHOOD</p><h2 id="hub-title">$($district.Name) 생활권별 수학과외</h2><div class="area-links">$($hubLinks -join "`n")</div></section>
      <section class="local-list" aria-labelledby="dong-title"><p class="section-number">$($district.Dongs.Count) AREAS</p><h2 id="dong-title">$($district.Name) 동별 수학과외</h2><div class="area-links">$($dongLinks -join "`n")</div></section>
$($guideLinksHtml.Replace('../../../', '../../'))
$districtCta
    </div>
  </main>
$districtFooter</body>
</html>
"@
    Write-Utf8File (Join-Path $PSScriptRoot "areas\$($district.Slug)\index.html") $districtHtml
    $pages.Insert($districtIndex, [pscustomobject]@{ Url = $districtUrl; Title = $districtTitle; Description = $districtDescription })

    foreach ($level in $levels) {
        $levelUrl = "$districtUrl$($level.Slug)/"
        $levelName = "$($district.Name) $($level.Short)수학 과외"
        $levelTitle = "$districtArea $($level.Short)수학 과외 | $($level.TitleTail)"
        $levelDescription = "$districtArea $($level.Short) 수학과외. $($level.Summary) 전화 상담 $phone"
        $levelLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @("$districtArea 수학과외", $districtUrl), @("$districtArea $($level.Short)수학 과외", $levelUrl))) + (Get-FaqLd $level.Faq)
        $levelHead = Get-Head $levelTitle $levelDescription $levelUrl '../../../styles.css' $levelLd
        $levelHeader = Get-Header '../../../'
        $levelSchools = Get-SchoolSection $districtArea $district.Slug @($level.Slug) '' '../../../'
        $gradeCards = foreach ($grade in $level.Grades) {
            $gradeParts = $grade.Split('|')
            "          <article><h3>$($district.Name) $($gradeParts[0]) 수학과외</h3><p>$($gradeParts[1])</p></article>"
        }
        $levelDongLinks = foreach ($dongEntry in $district.Dongs) {
            $parts = $dongEntry.Split('|')
            "        <a href=`"../$($parts[0])/`"><span>$($parts[1]) $($level.Short)수학</span><span aria-hidden=`"true`">→</span></a>"
        }
        $otherLevelLinks = foreach ($other in ($levels | Where-Object { $_.Slug -ne $level.Slug })) {
            "        <a href=`"../$($other.Slug)/`"><span>$($district.Name) $($other.Short)수학 과외</span><span aria-hidden=`"true`">→</span></a>"
        }
        $otherDistrictLinks = foreach ($other in ($districts | Where-Object { $_.Slug -ne $district.Slug })) {
            "        <a href=`"../../$($other.Slug)/$($level.Slug)/`"><span>$($other.Name) $($level.Short)수학 과외</span><span aria-hidden=`"true`">→</span></a>"
        }
        $levelFaqSection = Get-FaqSection "$districtArea $($level.Short) 수학과외 자주 묻는 질문" $level.Faq
        $levelCta = Get-Cta "$districtArea $($level.Short) 수학과외 상담"
        $levelFooter = Get-Footer '../../../'
        $levelHtml = @"
<!doctype html>
<html lang="ko">
<head>
$levelHead</head>
<body class="location-page">
$levelHeader
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../../../">대전</a><span>/</span><a href="../">$($district.Name)</a><span>/</span><strong>$($level.Short) 수학</strong></nav>
      <p class="eyebrow">DAEJEON · $($district.Name) · $($level.Eyebrow)</p>
      <h1>$districtArea<br>$($level.Short) 수학과외</h1>
      <p>$($level.Summary)</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">$($level.Eyebrow)</p><h2 id="intro-title">$($district.Name) $($level.Short)<br>수학수업</h2></div>
        <div class="location-intro-copy"><p>$($district.Character)</p><p>$districtArea $($level.Short) 수학과외는 최근 시험지와 교재로 현재 실력을 진단한 뒤, 학년 진도와 목표에 맞춰 $($level.Short) 수학수업의 순서를 정합니다. 개념이 비어 있으면 $($level.Short) 기초수학부터 채우고, 수업 뒤에는 혼자 하는 수학공부 범위를 구체적으로 안내합니다.</p></div>
      </section>
      <section class="grade-guide" aria-labelledby="grade-title">
        <p class="section-number">BY GRADE</p>
        <h2 id="grade-title">$($district.Name) $($level.Short)<br>학년별 수학과외</h2>
        <div class="grade-grid">
$($gradeCards -join "`n")
        </div>
      </section>
$levelSchools
$levelFaqSection
      <section class="local-list" aria-labelledby="dong-title"><p class="section-number">$($district.Dongs.Count) AREAS</p><h2 id="dong-title">$($district.Name) 동별 $($level.Short)수학</h2><div class="area-links">$($levelDongLinks -join "`n")</div></section>
      <section class="local-list" aria-labelledby="other-title"><p class="section-number">MORE</p><h2 id="other-title">다른 학년 · 다른 지역</h2><div class="area-links">$(($otherLevelLinks + $otherDistrictLinks) -join "`n")</div></section>
$guideLinksHtml
$levelCta
    </div>
  </main>
$levelFooter</body>
</html>
"@
        Write-Utf8File (Join-Path $PSScriptRoot "areas\$($district.Slug)\$($level.Slug)\index.html") $levelHtml
        $pages.Add([pscustomobject]@{ Url = $levelUrl; Title = $levelTitle; Description = $levelDescription })
    }
}

# 정보형 검색어(대전 과외 비용, 수학학원 추천, 과외 구하기)를 위한 가이드 페이지
$guides = @(
    [pscustomobject]@{
        Slug = 'cost'; Name = '수학과외 비용'
        Title = '대전 수학과외 비용 | 과외비가 정해지는 기준과 확인할 점'
        Description = '대전 수학과외 비용은 학년, 수업 횟수와 시간, 수업 방식에 따라 달라집니다. 과외비를 비교할 때 금액보다 먼저 확인해야 할 점을 정리했습니다.'
        H1 = '대전 수학과외 비용,<br>무엇으로 정해질까'
        Lead = '과외비는 학년과 수업 횟수만으로 정해지지 않습니다. 같은 금액이라도 진단과 관리가 포함되는지에 따라 실제 가치가 달라집니다.'
        Body = @'
        <h2>과외비를 정하는 네 가지 기준</h2>
        <ol>
          <li><strong>학년과 과정</strong> — 초등 수학, 중등 수학내신, 고등 수학내신과 수능대비는 준비량과 난도가 달라 비용 기준도 달라집니다.</li>
          <li><strong>수업 횟수와 시간</strong> — 주 1회인지 2~3회인지, 한 번에 몇 분 수업하는지가 월 비용을 가장 크게 좌우합니다.</li>
          <li><strong>수업 방식</strong> — 방문 대면 수업과 온라인 수업은 이동 시간과 준비 방식이 달라 조건이 다를 수 있습니다.</li>
          <li><strong>목표와 기간</strong> — 시험 4주 전 내신 집중 대비, 예비고1 방학 특강처럼 기간과 목표가 분명한 수업은 따로 계획합니다.</li>
        </ol>
        <h2>금액보다 먼저 확인할 것</h2>
        <ul>
          <li>첫 수업 전에 최근 시험지와 교재로 현재 실력을 진단하는지</li>
          <li>학교 시험 범위와 교과서를 반영한 내신 대비가 포함되는지</li>
          <li>과제와 오답을 다음 수업에서 확인하는지</li>
          <li>학부모에게 학습 상황을 정기적으로 알려 주는지</li>
        </ul>
        <p>회당 금액이 낮아도 진단과 관리가 빠지면 같은 내용을 반복하느라 기간이 길어질 수 있습니다. 반대로 횟수가 적어도 과제 관리가 잘 되면 학생 혼자 하는 수학공부 시간이 효율적으로 바뀝니다.</p>
        <h2>수학학원비와 비교할 때</h2>
        <p>수학학원은 여러 학생이 함께 수업해 같은 시간 기준으로는 비용 부담이 낮은 편입니다. 대신 한 학생에게 돌아가는 질문과 피드백 시간은 짧아집니다. 1:1 수학과외는 수업 시간 전체가 한 학생의 막힌 지점에 쓰인다는 점을 함께 비교해 보세요. 자세한 비교는 <a class="more-link" href="../academy-vs-tutoring/">수학학원 vs 1:1 과외</a>에 정리했습니다.</p>
        <h2>대전 수학과외 비용 안내</h2>
        <p>정확한 수업료는 학생의 학년, 주당 횟수, 수업 시간, 대면·온라인 여부에 따라 상담에서 안내해 드립니다. <a href="{TEL}">{PHONE}</a>로 전화 주시면 학생 상황을 듣고 알맞은 수업 횟수부터 함께 정합니다.</p>
'@
        Faq = @(
            '상담 비용이 있나요?|상담은 무료입니다. 학생의 학년과 현재 상황을 듣고 수업 방향과 비용을 안내해 드립니다.',
            '주 1회 수업으로도 효과가 있나요?|학생의 현재 실력과 목표에 따라 다릅니다. 기초가 많이 비어 있거나 시험이 가까우면 횟수를 늘리고, 습관이 잡힌 학생은 주 1회와 과제 관리로도 충분할 수 있습니다.',
            '초등, 중등, 고등 과외비가 다른가요?|과정별로 준비량과 난도가 달라 기준이 다를 수 있습니다. 정확한 금액은 상담에서 안내합니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'academy-vs-tutoring'; Name = '수학학원 vs 1:1 과외'
        Title = '대전 수학학원 vs 1:1 수학과외 | 우리 아이에게 맞는 선택 기준'
        Description = '대전 수학학원, 공부방, 교습소와 1:1 수학과외의 차이를 인원, 진도, 피드백, 내신 대비 기준으로 비교했습니다. 학원 추천을 찾기 전에 확인해 보세요.'
        H1 = '수학학원과 1:1 과외,<br>무엇이 맞을까'
        Lead = '좋은 학원과 좋은 과외 중 무엇이 더 낫다고 단정할 수는 없습니다. 학생의 공부 습관과 현재 실력에 따라 맞는 방식이 다릅니다.'
        Body = @'
        <h2>한눈에 비교하기</h2>
        <div class="table-wrap">
          <table>
            <thead><tr><th>구분</th><th>수학학원</th><th>공부방 · 교습소</th><th>1:1 수학과외</th></tr></thead>
            <tbody>
              <tr><th>인원</th><td>반 단위 다수</td><td>소규모 그룹</td><td>학생 1명</td></tr>
              <tr><th>진도</th><td>반 전체 기준</td><td>그룹 기준, 일부 개별</td><td>학생 한 명 기준</td></tr>
              <tr><th>질문 · 피드백</th><td>제한적</td><td>보통</td><td>수업 내내 가능</td></tr>
              <tr><th>학교별 내신</th><td>학교별 반이 있으면 가능</td><td>학생 구성에 따라 다름</td><td>다니는 학교 기준으로 대비</td></tr>
              <tr><th>일정</th><td>정해진 시간표</td><td>정해진 시간표</td><td>협의해 조정</td></tr>
            </tbody>
          </table>
        </div>
        <h2>수학학원이 잘 맞는 학생</h2>
        <ul>
          <li>모르는 것을 스스로 질문하고 정리하는 습관이 있는 학생</li>
          <li>정해진 진도를 따라가는 데 어려움이 없는 학생</li>
          <li>또래와 함께 공부할 때 자극을 받는 학생</li>
        </ul>
        <h2>1:1 수학과외가 잘 맞는 학생</h2>
        <ul>
          <li>이전 학년 개념에 빈틈이 있어 기초수학부터 다시 잡아야 하는 학생</li>
          <li>수업 중에 질문하기를 어려워하는 학생</li>
          <li>다니는 학교의 시험 범위와 기출 유형에 맞춘 수학내신 대비가 필요한 학생</li>
          <li>운동, 다른 학원 일정 때문에 시간표를 맞추기 어려운 학생</li>
          <li>수능수학의 특정 단원이나 문제 유형만 집중적으로 보완하려는 학생</li>
        </ul>
        <h2>학원과 과외를 함께 하는 경우</h2>
        <p>학원 진도는 따라가되 이해가 부족한 단원만 1:1 수업으로 보완하는 방법도 있습니다. 이때는 학원 교재와 과제를 함께 확인해 같은 내용을 두 번 배우지 않도록 역할을 나누는 것이 중요합니다.</p>
        <h2>결정 전 체크리스트</h2>
        <ol>
          <li>최근 시험에서 틀린 문제의 이유가 개념, 풀이 순서, 계산 실수 중 무엇인지</li>
          <li>학생이 지금 다니는 수업에서 질문을 하고 있는지</li>
          <li>숙제를 혼자 끝낼 수 있는지, 끝내도 오답이 반복되는지</li>
        </ol>
        <p>세 가지 중 두 가지 이상에서 막힌다면 1:1 수업으로 빈틈부터 채우는 것을 권합니다. 판단이 어렵다면 <a href="{TEL}">{PHONE}</a>로 전화 주세요. 학생 상황을 듣고 학원과 과외 중 어느 쪽이 맞을지 솔직하게 안내해 드립니다.</p>
'@
        Faq = @(
            '수학학원과 과외를 같이 다녀도 되나요?|가능합니다. 학원 진도는 유지하고 이해가 부족한 단원만 1:1 수업으로 보완하면 부담을 줄이면서 빈틈을 채울 수 있습니다.',
            '공부방과 1:1 과외는 무엇이 다른가요?|공부방은 소규모 그룹이 함께 공부하는 경우가 많고, 1:1 과외는 수업 시간 전체를 한 학생의 진도와 질문에 씁니다.',
            '중학생은 학원과 과외 중 무엇이 좋나요?|학교별 수학내신 대비가 중요한 시기라 학생이 다니는 학교 기준으로 준비할 수 있는지가 핵심입니다. 기초 빈틈이 있다면 1:1 수업이 효과적입니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'choose-tutor'; Name = '과외 선생님 고르는 법'
        Title = '대전 수학과외 선생님 고르는 법 | 상담 전 체크리스트'
        Description = '대전에서 수학과외 선생님을 구할 때 상담 전에 준비할 것과 꼭 물어봐야 할 질문, 첫 달에 확인할 변화를 체크리스트로 정리했습니다.'
        H1 = '수학과외 선생님,<br>이렇게 고르세요'
        Lead = '과외를 구할 때는 경력이나 학벌보다 우리 아이의 문제를 어떻게 진단하고 어떤 계획을 세우는지가 더 중요합니다.'
        Body = @'
        <h2>상담 전에 준비할 것</h2>
        <ul>
          <li>최근 학교 시험지와 성적표</li>
          <li>지금 사용하는 교재와 학원 교재</li>
          <li>다니는 학교와 학년, 다음 시험 일정</li>
          <li>목표(내신 점수, 수능 등급, 기초 회복 등)와 가능한 수업 요일·시간</li>
        </ul>
        <h2>상담에서 꼭 물어볼 질문</h2>
        <ol>
          <li><strong>첫 수업 전에 어떻게 진단하나요?</strong> 시험지와 교재를 보고 막힌 지점을 구체적으로 짚는지 확인하세요.</li>
          <li><strong>한 달 수업 계획을 설명해 줄 수 있나요?</strong> 어떤 단원을 어떤 순서로 다룰지 말할 수 있어야 합니다.</li>
          <li><strong>학교 내신은 어떻게 대비하나요?</strong> 교과서, 학교 프린트, 기출 유형을 반영하는지 물어보세요.</li>
          <li><strong>과제와 오답은 어떻게 관리하나요?</strong> 숙제를 내기만 하는지, 다음 수업에서 풀이 과정을 함께 확인하는지가 중요합니다.</li>
          <li><strong>학부모에게는 어떻게 알려 주나요?</strong> 학습 상황을 공유하는 주기와 방법을 확인하세요.</li>
          <li><strong>대면과 온라인 중 어떤 방식이 가능한가요?</strong> 이동 거리와 일정까지 고려해 결정합니다.</li>
        </ol>
        <h2>첫 달에 확인할 변화</h2>
        <ul>
          <li>학생이 수업 내용을 자기 말로 설명할 수 있게 되었는지</li>
          <li>같은 유형의 오답이 줄어들고 있는지</li>
          <li>숙제를 미루지 않고 스스로 시작하는지</li>
        </ul>
        <p>점수는 시험이 지나야 확인되지만, 이런 변화는 첫 달 안에도 보입니다. 변화가 없다면 수업 방식이나 과제량을 조정해 달라고 요청하세요.</p>
        <h2>대전 수학과외 상담 안내</h2>
        <p>학생의 학년과 현재 상황을 알려 주시면 진단 방법과 수업 계획을 구체적으로 설명해 드립니다. 비용 기준은 <a class="more-link" href="../cost/">수학과외 비용</a>에서 먼저 확인할 수 있습니다. 상담은 <a href="{TEL}">{PHONE}</a>로 전화 주세요.</p>
'@
        Faq = @(
            '과외 선생님을 바꾸는 게 좋은 시점은 언제인가요?|두세 달이 지나도 오답 유형이 그대로이고, 수업 계획에 대한 설명이 없다면 수업 방식을 점검해 보는 것이 좋습니다.',
            '학생과 선생님이 잘 맞는지 어떻게 알 수 있나요?|첫 몇 번의 수업 뒤 학생이 질문을 편하게 하는지, 수업 내용을 설명할 수 있는지 물어보세요.',
            '대전 어느 지역까지 수업하나요?|대전 서구, 유성구, 중구, 동구, 대덕구 전 지역 상담이 가능하며, 위치와 시간에 따라 대면 수업 가능 여부를 안내합니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'middle-school-grades'; Name = '중학교 수학 내신'
        Title = '대전 중학교 수학 내신 | 성취도 A~E 기준과 학년별 관리법'
        Description = '대전 중학교 수학 내신은 성취도 A~E와 원점수, 과목평균으로 기록됩니다. 성취도 기준, 지필·수행평가 준비, 중1·중2·중3 학년별 수학 내신 관리법을 정리했습니다.'
        H1 = '대전 중학교<br>수학 내신 관리법'
        Lead = '중학교 수학 내신은 고입과 고등 수학의 출발점입니다. 성적이 어떻게 기록되는지 알면 무엇을 준비해야 할지가 분명해집니다.'
        Body = @'
        <h2>중학교 수학 성적은 이렇게 기록됩니다</h2>
        <p>중학교는 성취평가제로 성적을 기록합니다. 지필평가와 수행평가를 합산한 점수에 따라 다섯 단계 성취도가 매겨지고, 생활기록부에는 성취도와 함께 원점수, 과목평균, 표준편차가 기재됩니다.</p>
        <div class="table-wrap">
          <table>
            <thead><tr><th>성취도</th><th>합산 점수</th></tr></thead>
            <tbody>
              <tr><th>A</th><td>90점 이상</td></tr>
              <tr><th>B</th><td>80점 이상 90점 미만</td></tr>
              <tr><th>C</th><td>70점 이상 80점 미만</td></tr>
              <tr><th>D</th><td>60점 이상 70점 미만</td></tr>
              <tr><th>E</th><td>60점 미만</td></tr>
            </tbody>
          </table>
        </div>
        <p>A와 B를 가르는 것은 대부분 서술형 감점과 계산 실수입니다. 아는 문제를 끝까지 정확하게 쓰는 연습이 성취도를 지키는 가장 확실한 방법입니다.</p>
        <h2>대전 고입 내신 산출은 요강으로 확인하세요</h2>
        <p>대전 고등학교 입학 전형에서 중학교 성적을 반영하는 학년, 비율, 산출 방법은 대전광역시교육청이 해마다 발표하는 고등학교 입학전형 기본계획에 따라 달라질 수 있습니다. 내신 점수를 계산할 때는 반드시 해당 연도 요강을 확인하세요. 어느 방식이든 교과 성적의 비중이 크기 때문에 수학 성취도를 꾸준히 관리하는 것이 중요합니다.</p>
        <h2>지필평가와 수행평가 준비</h2>
        <ul>
          <li><strong>지필평가</strong> — 교과서 예제와 익힘 문제, 학교 프린트에서 출제되는 비중이 큽니다. 다니는 학교의 교과서 출판사와 시험 범위부터 확인합니다.</li>
          <li><strong>서술형</strong> — 풀이 과정의 식과 근거를 빠짐없이 쓰는지 채점 기준에 맞춰 연습합니다.</li>
          <li><strong>수행평가</strong> — 반영 비율과 평가 방식이 학교마다 다릅니다. 학기 초 평가 계획을 확인하고 일정을 놓치지 않도록 관리합니다.</li>
        </ul>
        <h2>학년별 수학 내신 포인트</h2>
        <ul>
          <li><strong>중1</strong> — 정수와 유리수, 문자와 식, 일차방정식. 자유학기 운영으로 학기에 따라 지필평가가 없을 수 있으니 학교 일정을 확인하고, 시험이 없는 기간에도 개념 정리를 이어갑니다.</li>
          <li><strong>중2</strong> — 연립방정식과 일차함수가 본격적으로 등장해 성적 차이가 커지는 시기입니다. 함수 그래프 해석과 서술형 풀이를 집중 관리합니다.</li>
          <li><strong>중3</strong> — 인수분해, 이차방정식, 이차함수는 고등 공통수학으로 바로 이어집니다. 내신 대비와 함께 예비고1 준비를 시작합니다.</li>
        </ul>
        <h2>시험 4주 전 대비 순서</h2>
        <ol>
          <li>4주 전: 시험 범위 개념 정리와 교과서 문제 다시 풀기</li>
          <li>3주 전: 학교 프린트와 기출 유형 풀이</li>
          <li>2주 전: 서술형 집중 연습과 오답 정리</li>
          <li>1주 전: 실전처럼 시간 재고 풀기, 자주 틀리는 유형 마지막 점검</li>
        </ol>
        <p>중등 수학내신 대비는 학생이 다니는 학교 기준으로 준비해야 효과가 있습니다. 학교와 학년을 알려 주시면 맞춤 대비 계획을 안내해 드립니다. <a href="{TEL}">{PHONE}</a></p>
'@
        Faq = @(
            '중학교 수학 성취도 A를 받으려면 몇 점이어야 하나요?|지필평가와 수행평가를 합산한 점수가 90점 이상이면 A입니다. 학교마다 지필과 수행의 반영 비율이 다르니 학기 초 평가 계획을 확인하세요.',
            '대전 중학교 내신은 몇 학년부터 반영되나요?|반영 학년과 비율은 대전광역시교육청의 해당 연도 고등학교 입학전형 기본계획에 따라 정해지므로 최신 요강을 확인해야 합니다.',
            '중학교 수학 서술형은 어떻게 준비하나요?|모범 답안의 식과 근거를 그대로 쓰는 연습부터 시작해, 채점 기준에서 감점되는 부분을 오답 노트로 정리하는 것이 효과적입니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'high-school-grades'; Name = '고등 수학 내신 5등급제'
        Title = '대전 고등학교 수학 내신 | 5등급제에서 달라진 점과 대비법'
        Description = '고등학교 내신 5등급제에서 수학 등급이 어떻게 나뉘는지, 공통수학1·2와 대수·미적분Ⅰ·확률과 통계 과목 구성, 대전 고등학생의 수학 내신 대비법을 정리했습니다.'
        H1 = '고등 수학 내신,<br>5등급제 대비법'
        Lead = '2025학년도 고1부터 고등학교 내신이 5등급제로 바뀌었습니다. 등급 구간이 넓어진 만큼 한 문제의 실수가 등급을 가르는 구조를 이해해야 합니다.'
        Body = @'
        <h2>5등급제 등급 구간</h2>
        <p>2022 개정 교육과정이 적용되는 2025학년도 고1부터는 상대평가 등급이 9단계에서 5단계로 줄었고, 성취도(A~E)도 함께 기재됩니다.</p>
        <div class="table-wrap">
          <table>
            <thead><tr><th>등급</th><th>누적 비율</th></tr></thead>
            <tbody>
              <tr><th>1등급</th><td>상위 10%까지</td></tr>
              <tr><th>2등급</th><td>상위 34%까지</td></tr>
              <tr><th>3등급</th><td>상위 66%까지</td></tr>
              <tr><th>4등급</th><td>상위 90%까지</td></tr>
              <tr><th>5등급</th><td>나머지</td></tr>
            </tbody>
          </table>
        </div>
        <p>1등급 비율이 넓어진 대신 같은 1등급 안에서도 점수 차이가 다양해지고, 1등급과 2등급 경계에서는 서술형 한 문항이나 계산 실수 하나가 결과를 바꿀 수 있습니다.</p>
        <h2>고등 수학 과목 구성</h2>
        <ul>
          <li><strong>고1</strong> — 공통수학1, 공통수학2. 다항식, 방정식과 부등식, 경우의 수, 행렬, 도형의 방정식, 집합과 명제, 함수를 다룹니다.</li>
          <li><strong>고2 이후</strong> — 대수, 미적분Ⅰ, 확률과 통계 등 선택 과목을 학교 편성에 따라 배웁니다. 대수, 미적분Ⅰ, 확률과 통계는 수능 수학 출제 범위와도 연결됩니다.</li>
        </ul>
        <p>학교마다 과목 편성 학기와 진로 선택 과목이 다르기 때문에, 다니는 학교의 교육과정 편성표를 먼저 확인하는 것이 좋습니다.</p>
        <h2>5등급제에서 수학 내신 대비법</h2>
        <ol>
          <li><strong>실수를 줄이는 훈련</strong> — 등급 경계에서는 어려운 문제보다 쉬운 문제의 실수가 더 치명적입니다. 검산 습관과 풀이 정리를 수업마다 확인합니다.</li>
          <li><strong>학교 기출 분석</strong> — 학교별로 출제 경향과 서술형 비중이 다릅니다. 기출 유형과 학교 프린트를 기준으로 대비합니다.</li>
          <li><strong>수행평가 관리</strong> — 지필 점수 차이가 작을수록 수행평가가 등급에 미치는 영향이 커집니다.</li>
          <li><strong>공통수학 기초</strong> — 고1 공통수학이 흔들리면 이후 대수와 미적분Ⅰ 전체가 어려워집니다. 고1 1학기부터 개념을 확실히 다집니다.</li>
        </ol>
        <h2>내신과 수능을 함께 준비하려면</h2>
        <p>고2부터 배우는 대수, 미적분Ⅰ, 확률과 통계는 내신 과목이면서 수능 수학으로도 이어집니다. 시험 기간에는 학교 내신에 집중하고, 그 외 기간에는 같은 단원의 수능형 문제로 개념을 연결하면 두 가지를 효율적으로 준비할 수 있습니다.</p>
        <p>학생의 학교와 학년, 목표 등급을 알려 주시면 내신과 수능대비 계획을 함께 세워 드립니다. <a href="{TEL}">{PHONE}</a></p>
'@
        Faq = @(
            '고등학교 내신 5등급제는 언제부터 적용되나요?|2022 개정 교육과정이 적용되는 2025학년도 고등학교 1학년부터 적용됩니다.',
            '5등급제에서 수학 1등급은 상위 몇 %인가요?|상위 10%까지가 1등급입니다. 2등급은 누적 34%, 3등급은 66%, 4등급은 90%까지입니다.',
            '고1 공통수학은 언제부터 준비하면 좋나요?|중3 2학기부터 예비고1 과정으로 중학 핵심 개념을 정리하고, 공통수학1의 다항식과 방정식 단원을 미리 다루는 것을 권합니다.'
        )
    },
    [pscustomobject]@{
        Slug = 'school-district'; Name = '대전 학군지 수학'
        Title = '대전 학군지 수학 공부 | 둔산·노은·도안·관평 생활권별 전략'
        Description = '대전에서 학군지로 자주 이야기되는 둔산동, 노은동, 도안, 관평동의 학습 환경과 수학 공부 전략, 학군지로 이사·전학하기 전 수학 준비 방법을 정리했습니다.'
        H1 = '대전 학군지,<br>수학은 어떻게 준비할까'
        Lead = '학군지는 학원과 학습 정보가 많은 만큼 시험 난도와 진도 경쟁도 높은 편입니다. 지역보다 중요한 것은 그 환경에서 우리 아이가 따라갈 준비가 되어 있는지입니다.'
        Body = @'
        <h2>대전에서 학군지로 자주 이야기되는 곳</h2>
        <ul>
          <li><strong>둔산동 (서구)</strong> — 대전시청과 정부대전청사 주변으로 학원가가 밀집해 있습니다. 학교별 내신 경쟁이 치열한 편이라 학교 프린트와 기출 유형까지 반영한 대비가 중요합니다. <a href="../../areas/seo-gu/dunsan/">둔산동 수학과외</a></li>
          <li><strong>노은동 (유성구)</strong> — 노은역 주변으로 주거 단지가 모여 있고, 학교마다 진도와 시험 일정이 달라 학교 기준의 계획이 필요합니다. <a href="../../areas/yuseong-gu/noeun/">노은동 수학과외</a></li>
          <li><strong>도안 (서구 도안동 일대)</strong> — 신도시로 조성된 주거 지역으로 초등부터 중등까지 학생 연령대가 넓습니다. <a href="../../areas/seo-gu/doan/">도안동 수학과외</a></li>
          <li><strong>관평동 (유성구)</strong> — 대덕테크노밸리와 가까운 주거 지역으로 수학학원과 공부방 수요가 많습니다. <a href="../../areas/yuseong-gu/gwanpyeong/">관평동 수학과외</a></li>
        </ul>
        <p>학군에 대한 평가는 기준과 시기에 따라 달라지므로, 학교 선택은 학업성취도 공시 자료와 실제 통학 여건을 함께 살펴 판단하는 것을 권합니다.</p>
        <h2>학군지에서 수학 공부가 달라지는 점</h2>
        <ul>
          <li><strong>시험 난도</strong> — 변별을 위해 고난도 문항과 서술형 비중이 높은 경우가 있어, 기본 개념만으로는 점수를 지키기 어렵습니다.</li>
          <li><strong>선행 속도</strong> — 주변 학생들의 선행이 빨라 학생도 진도를 서두르기 쉽습니다. 현재 학년 개념에 빈틈이 있는 상태의 선행은 오히려 내신을 흔들 수 있습니다.</li>
          <li><strong>학원 선택지</strong> — 선택지가 많은 만큼 학생에게 맞지 않는 반에 들어가 진도만 따라가는 경우도 생깁니다.</li>
        </ul>
        <h2>학군지로 이사·전학하기 전 수학 준비</h2>
        <ol>
          <li>옮겨 갈 학교의 교과서 출판사와 현재 진도를 확인합니다.</li>
          <li>전 학교에서 배우지 않았거나 순서가 달라 비어 있는 단원을 찾아 먼저 채웁니다.</li>
          <li>새 학교의 기출 유형으로 첫 시험을 미리 준비합니다.</li>
        </ol>
        <h2>학군지가 아니어도 괜찮습니다</h2>
        <p>성적을 결정하는 것은 주소보다 학생의 개념 이해와 공부 습관입니다. 어느 동네에 살든 학생이 다니는 학교의 시험 범위와 출제 경향에 맞춰 준비하면 충분히 좋은 결과를 낼 수 있습니다. 지역별 안내는 <a class="more-link" href="../../#area">대전 구별 수학과외</a>에서 볼 수 있습니다.</p>
        <p>이사나 전학을 앞두고 있다면 <a href="{TEL}">{PHONE}</a>로 전화 주세요. 학생의 현재 진도와 옮겨 갈 학교에 맞춰 준비 순서를 안내해 드립니다.</p>
'@
        Faq = @(
            '대전에서 학군지로 꼽히는 곳은 어디인가요?|흔히 서구 둔산동, 유성구 노은동과 관평동, 도안 일대가 이야기됩니다. 다만 평가는 기준과 시기에 따라 달라 학업성취도 공시 자료와 통학 여건을 함께 보는 것이 좋습니다.',
            '학군지로 전학하면 수학 성적이 떨어지나요?|시험 난도와 진도가 달라 첫 시험에서 어려움을 겪는 경우가 있습니다. 전학 전에 새 학교의 진도와 기출 유형을 확인하고 비어 있는 단원을 채우면 충분히 대비할 수 있습니다.',
            '학군지 학생은 선행을 꼭 해야 하나요?|현재 학년 개념이 탄탄하다면 선행이 도움이 되지만, 빈틈이 있는 상태의 선행은 내신을 흔들 수 있습니다. 진단으로 순서를 정하는 것이 우선입니다.'
        )
    }
)

foreach ($guide in $guides) {
    $guideUrl = "$siteUrl/guide/$($guide.Slug)/"
    $guideLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @($guide.Name, $guideUrl))) + (Get-FaqLd $guide.Faq)
    $guideHead = Get-Head $guide.Title $guide.Description $guideUrl '../../styles.css' $guideLd
    $guideHeader = Get-Header '../../'
    $guideBody = $guide.Body.Replace('{TEL}', $phoneTel).Replace('{PHONE}', $phone)
    $guideFaqSection = Get-FaqSection "자주 묻는 질문" $guide.Faq
    $otherGuides = @($guides | Where-Object { $_.Slug -ne $guide.Slug } | ForEach-Object { "        <a href=`"../$($_.Slug)/`"><span>$($_.Name)</span><span aria-hidden=`"true`">→</span></a>" })
    $districtGuideLinks = @($districts | ForEach-Object { "        <a href=`"../../areas/$($_.Slug)/`"><span>대전 $($_.Name) 수학과외</span><span aria-hidden=`"true`">→</span></a>" })
    $guideCta = Get-Cta '대전 수학과외 상담'
    $guideFooter = Get-Footer '../../'
    $guideHtml = @"
<!doctype html>
<html lang="ko">
<head>
$guideHead</head>
<body class="location-page">
$guideHeader
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../../">대전</a><span>/</span><strong>$($guide.Name)</strong></nav>
      <p class="eyebrow">DAEJEON MATH TUTORING GUIDE</p>
      <h1>$($guide.H1)</h1>
      <p>$($guide.Lead)</p>
    </section>
    <div class="location-layout">
      <article class="guide-body">
$guideBody      </article>
$guideFaqSection
      <section class="local-list" aria-labelledby="more-title"><p class="section-number">MORE</p><h2 id="more-title">함께 보면 좋은 글 · 지역별 안내</h2><div class="area-links">$(($otherGuides + $districtGuideLinks) -join "`n")</div></section>
$guideCta
    </div>
  </main>
$guideFooter</body>
</html>
"@
    Write-Utf8File (Join-Path $PSScriptRoot "guide\$($guide.Slug)\index.html") $guideHtml
    $pages.Insert(1, [pscustomobject]@{ Url = $guideUrl; Title = $guide.Title; Description = $guide.Description })
}

# 중·고등학교별 페이지. 학교명/약칭 + 수학과외·내신 검색어를 위한 페이지로, 주소와 가까운 학교 목록은 표준데이터 기준
$schoolById = @{}
foreach ($school in $schoolData) { $schoolById[$school.id] = $school }
$areaPathByName = @{}
foreach ($district in $districts) {
    $areaPathByName[$district.Slug] = @{}
    foreach ($dongEntry in $district.Dongs) { $parts = $dongEntry.Split('|'); $areaPathByName[$district.Slug][$parts[1]] = $parts[0] }
    foreach ($hubEntry in $hubs[$district.Slug]) { $parts = $hubEntry.Split('|'); $areaPathByName[$district.Slug][$parts[1]] = $parts[0] }
}
$districtNames = @{}
foreach ($district in $districts) { $districtNames[$district.Slug] = $district.Name }
$levelInfo = @{}
foreach ($level in $levels) { $levelInfo[$level.Slug] = $level }

function Get-SchoolNote($School) {
    $n = $School.name
    if ($n -match '^(대전과학|대전동신과학)고등학교$') { return '과학고는 수학·과학 심화 과정의 비중이 높아 교과 수학의 개념 깊이와 증명형 서술 풀이까지 대비해야 합니다.' }
    if ($n -match '예술|체육') { return '실기와 훈련 일정 때문에 수업 시간을 고정하기 어려운 경우가 많아, 학생 일정에 맞춰 수업 시간과 과제 분량을 조정합니다.' }
    if ($n -match '마이스터|디지텍|기계공업|상업|국제통상|전자디자인|생활과학|생명과학|도시과학') { return '전공 교과와 함께 공통 수학 과목의 기초를 다지는 것이 중요합니다. 취업과 진학 목표에 맞춰 꼭 필요한 단원부터 정리합니다.' }
    if ($n -match '외국어') { return '어학 중심 교육과정이라도 수학 내신은 대학 진학에 그대로 반영되므로, 적은 수업 시수 안에서 시험 범위를 효율적으로 대비해야 합니다.' }
    if ($School.found -eq '사립') { return '사립학교는 교사 이동이 적어 학교별 출제 경향이 비교적 일정하게 이어지는 경우가 많아, 기출 유형 분석의 효과가 큰 편입니다.' }
    return ''
}

$schoolPages = @($schoolData | Where-Object { $_.level -ne 'elementary' })
foreach ($school in $schoolPages) {
    $short = $school.short
    $districtName = $districtNames[$school.district]
    $districtArea = "대전 $districtName"
    $schoolUrl = "$siteUrl/school/$($school.id)/"
    $isHigh = $school.level -eq 'high'
    $levelLabel = $levelLabels[$school.level]
    $focus = if ($isHigh) { '수학 내신·수능대비' } else { '수학 내신 대비' }
    $schoolTitle = "$short 수학과외 | $($school.name) $focus 1:1 ($districtArea)"
    $schoolDescription = "$($school.name)($short) 학생을 위한 1:1 수학과외. 학교 교과서와 시험 범위, 기출 유형에 맞춘 $focus. $($school.road). 전화 상담 $phone"
    $areaSlug = $areaPathByName[$school.district][$school.dong]
    $areaLink = if ($areaSlug) { "<a href=`"../../areas/$($school.district)/$areaSlug/`">$($school.dong) 수학과외</a> · " } else { '' }
    $areaLink += "<a href=`"../../areas/$($school.district)/`">$districtArea 수학과외</a>"
    $note = Get-SchoolNote $school
    $noteHtml = if ($note) { "<p>$note</p>" } else { '' }
    if ($isHigh) {
        $gradeSource = $levelInfo['high'].Grades | Select-Object -First 3
        $examCopy = "<p>$short 학생의 수학 내신은 2025학년도 고1부터 5등급제로 산출되고 성취도(A~E)도 함께 기재됩니다. 1등급과 2등급 경계에서는 서술형 한 문항이나 계산 실수 하나가 결과를 바꿀 수 있어, 학교 기출 유형과 학교 프린트를 기준으로 실수를 줄이는 훈련이 중요합니다.</p><p>고1 공통수학1·2부터 고2 이후 대수, 미적분Ⅰ, 확률과 통계까지 학교 편성에 맞춰 내신을 준비하고, 같은 단원을 수능형 문제로 연결해 수능대비까지 함께 설계합니다. 자세한 기준은 <a class=`"more-link`" href=`"../../guide/high-school-grades/`">고등 수학 내신 5등급제</a>에 정리했습니다.</p>"
        $feederTitle = "$short 주변 중학교"
        $faqLevel = "$short 내신과 수능대비를 함께 할 수 있나요?|학교 시험 기간에는 $short 시험 범위와 기출 유형에 집중하고, 그 외 기간에는 같은 단원의 수능수학 문제로 개념을 연결해 두 가지를 함께 준비합니다."
    } else {
        $gradeSource = $levelInfo['middle'].Grades | Select-Object -First 3
        $examCopy = "<p>$short 학생의 수학 성적은 성취도 A~E와 원점수, 과목평균으로 기록되며, 지필평가와 수행평가 비율은 학교 평가 계획에 따라 정해집니다. 성취도 A와 B를 가르는 것은 대부분 서술형 감점과 계산 실수입니다.</p><p>$short 교과서 출판사와 시험 범위를 먼저 확인하고, 학교 프린트와 기출 유형에 맞춰 서술형 풀이까지 대비합니다. 중3은 내신과 함께 예비고1 준비를 시작합니다. 자세한 기준은 <a class=`"more-link`" href=`"../../guide/middle-school-grades/`">중학교 수학 내신 관리법</a>에 정리했습니다.</p>"
        $feederTitle = "$short 주변 초등학교"
        $faqLevel = "$short 서술형과 수행평가도 대비하나요?|$short 평가 계획을 확인해 지필평가 서술형은 채점 기준에 맞춰 연습하고, 수행평가 일정과 과제도 함께 관리합니다."
    }
    $gradeCards = foreach ($grade in $gradeSource) {
        $gradeParts = $grade.Split('|')
        "          <article><h3>$short $($gradeParts[0]) 수학</h3><p>$($gradeParts[1])</p></article>"
    }
    $nearSameLinks = foreach ($otherId in $school.nearSame) {
        $other = $schoolById[$otherId]
        "        <a href=`"../$($other.id)/`"><span>$($other.short) 수학과외</span><span aria-hidden=`"true`">→</span></a>"
    }
    $feederItems = foreach ($otherId in $school.nearFeeder) { Get-SchoolItem $schoolById[$otherId] '../../' }
    $schoolFaq = @(
        "$short 시험 범위에 맞춰 수업하나요?|네. $($school.name) 교과서와 시험 범위, 학교 프린트, 기출 유형을 확인해 학생이 다니는 학교 기준으로 내신을 대비합니다.",
        $faqLevel,
        "$short 근처에서 대면 수업이 가능한가요?|$districtArea $($school.dong) 일대를 포함해 학생의 위치와 희망 시간에 따라 대면 수업 가능 여부를 안내하며, 온라인 수업도 협의할 수 있습니다. $($phone)로 전화 주세요."
    )
    $schoolLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @('학교별 수학과외', "$siteUrl/school/"), @("$short 수학과외", $schoolUrl))) + (Get-FaqLd $schoolFaq)
    $schoolHead = Get-Head $schoolTitle $schoolDescription $schoolUrl '../../styles.css' $schoolLd
    $schoolHeader = Get-Header '../../'
    $schoolFaqSection = Get-FaqSection "$short 수학과외 자주 묻는 질문" $schoolFaq
    $schoolCta = Get-Cta "$short 수학과외 상담"
    $schoolFooter = Get-Footer '../../'
    $schoolHtml = @"
<!doctype html>
<html lang="ko">
<head>
$schoolHead</head>
<body class="location-page">
$schoolHeader
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../../">대전</a><span>/</span><a href="../">학교별</a><span>/</span><strong>$($school.name)</strong></nav>
      <p class="eyebrow">DAEJEON · $districtName · $($school.dong)</p>
      <h1>$short<br>수학과외</h1>
      <p>$($school.name) 학생의 교과서와 시험 범위, 기출 유형에 맞춰 1:1로 $($focus)를 준비합니다.</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">SCHOOL</p><h2 id="intro-title">$short<br>수학 내신 대비</h2></div>
        <div class="location-intro-copy">
          <dl class="school-facts">
            <div><dt>학교명</dt><dd>$($school.name)</dd></div>
            <div><dt>학교급 · 설립</dt><dd>$levelLabel · $($school.found)</dd></div>
            <div><dt>주소</dt><dd>$($school.road)</dd></div>
            <div><dt>지역 안내</dt><dd>$areaLink</dd></div>
          </dl>
          $noteHtml$examCopy
        </div>
      </section>
      <section class="grade-guide" aria-labelledby="grade-title">
        <p class="section-number">BY GRADE</p>
        <h2 id="grade-title">$short<br>학년별 수학 포인트</h2>
        <div class="grade-grid">
$($gradeCards -join "`n")
        </div>
      </section>
$schoolFaqSection
      <section class="local-list" aria-labelledby="near-title"><p class="section-number">NEARBY</p><h2 id="near-title">$short 주변 $levelLabel 수학과외</h2><div class="area-links">$($nearSameLinks -join "`n")</div></section>
      <section class="school-guide" aria-labelledby="feeder-title"><p class="section-number">NEARBY SCHOOLS</p><h2 id="feeder-title">$feederTitle</h2><ul class="school-list">$($feederItems -join '')</ul><p class="school-source">학교 정보 출처: 전국초중등학교위치표준데이터(2026년 10월 기준). 주변 학교는 좌표상 직선거리 기준입니다.</p></section>
$schoolCta
    </div>
  </main>
$schoolFooter</body>
</html>
"@
    Write-Utf8File (Join-Path $PSScriptRoot "school\$($school.id)\index.html") $schoolHtml
    $pages.Add([pscustomobject]@{ Url = $schoolUrl; Title = $schoolTitle; Description = $schoolDescription })
}

# 학교별 페이지 목록
$schoolIndexGroups = foreach ($district in $districts) {
    $levelBlocks = foreach ($levelSlug in @('middle', 'high')) {
        $items = ($schoolPages | Where-Object { $_.district -eq $district.Slug -and $_.level -eq $levelSlug } | ForEach-Object { "<li><a href=`"$($_.id)/`">$($_.name)</a></li>" }) -join ''
        "          <div class=`"school-group`"><h3>대전 $($district.Name) $($levelLabels[$levelSlug]) 수학과외</h3><ul class=`"school-list`">$items</ul></div>"
    }
    $levelBlocks -join "`n"
}
$schoolIndexUrl = "$siteUrl/school/"
$schoolIndexTitle = '대전 학교별 수학과외 | 중학교·고등학교 수학 내신 대비 1:1'
$schoolIndexDescription = "대전 중학교 $(@($schoolPages | Where-Object { $_.level -eq 'middle' }).Count)곳, 고등학교 $(@($schoolPages | Where-Object { $_.level -eq 'high' }).Count)곳의 학교별 수학과외 안내. 다니는 학교의 교과서와 시험 범위, 기출 유형에 맞춰 수학 내신을 대비합니다. 전화 상담 $phone"
$schoolIndexLd = Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @('학교별 수학과외', $schoolIndexUrl))
$schoolIndexHead = Get-Head $schoolIndexTitle $schoolIndexDescription $schoolIndexUrl '../styles.css' $schoolIndexLd
$schoolIndexHtml = @"
<!doctype html>
<html lang="ko">
<head>
$schoolIndexHead</head>
<body class="location-page">
$(Get-Header '../')
  <main class="location-main" id="main">
    <section class="location-hero">
      <nav class="breadcrumbs" aria-label="현재 위치"><a href="../">대전</a><span>/</span><strong>학교별</strong></nav>
      <p class="eyebrow">DAEJEON · SCHOOLS</p>
      <h1>대전 학교별<br>수학과외</h1>
      <p>다니는 학교의 교과서와 시험 범위, 기출 유형에 맞춰 중등 수학내신과 고등 수학내신·수능대비를 준비합니다.</p>
    </section>
    <div class="location-layout">
      <section class="school-guide" aria-labelledby="school-title">
        <p class="section-number">MIDDLE · HIGH SCHOOLS</p>
        <h2 id="school-title">구별 중학교·고등학교</h2>
$($schoolIndexGroups -join "`n")
        <p class="school-source">학교 정보 출처: 전국초중등학교위치표준데이터(2026년 10월 기준).</p>
      </section>
$(Get-Cta '대전 학교별 수학과외 상담')
    </div>
  </main>
$(Get-Footer '../')</body>
</html>
"@
Write-Utf8File (Join-Path $PSScriptRoot 'school\index.html') $schoolIndexHtml
$pages.Insert(1, [pscustomobject]@{ Url = $schoolIndexUrl; Title = $schoolIndexTitle; Description = $schoolIndexDescription })

$sitemapEntries = $pages | ForEach-Object { "  <url><loc>$($_.Url)</loc><lastmod>$today</lastmod></url>" }
$sitemap = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
$($sitemapEntries -join "`n")
</urlset>
"@
Write-Utf8File (Join-Path $PSScriptRoot 'sitemap.xml') $sitemap

# 네이버 서치어드바이저 RSS 제출용 피드
$pubDate = (Get-Date).ToUniversalTime().ToString('r')
$rssItems = $pages | ForEach-Object { "    <item><title>$($_.Title)</title><link>$($_.Url)</link><guid>$($_.Url)</guid><description>$($_.Description)</description><pubDate>$pubDate</pubDate></item>" }
$rss = @"
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>대전 수학과외</title>
    <link>$siteUrl/</link>
    <description>대전 초등·중등·고등 1:1 수학과외 지역별 안내</description>
    <language>ko</language>
$($rssItems -join "`n")
  </channel>
</rss>
"@
Write-Utf8File (Join-Path $PSScriptRoot 'rss.xml') $rss

$levelCount = $districts.Count * $levels.Count
$hubCount = @($hubs.Values | ForEach-Object { $_ }).Count
$dongCount = $pages.Count - $districts.Count - $levelCount - $hubCount - $guides.Count - $schoolPages.Count - 2
Write-Output "Generated $($districts.Count) district, $levelCount grade-level, $hubCount neighborhood hub, $dongCount neighborhood and $($guides.Count) guide and $($schoolPages.Count) school pages."
