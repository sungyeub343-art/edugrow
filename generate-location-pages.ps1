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
    <nav class="footer-links" aria-label="수학과외 가이드"><a href="${HomePath}guide/cost/">수학과외 비용</a><a href="${HomePath}guide/academy-vs-tutoring/">수학학원 vs 1:1 과외</a><a href="${HomePath}guide/choose-tutor/">과외 선생님 고르는 법</a></nav>
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
        <a href="../../../guide/choose-tutor/"><span>과외 선생님 고르는 법</span><span aria-hidden="true">→</span></a></div></section>
"@

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
        $dongDescription = "$districtArea $dongName 수학과외. 초등 기초수학, 중등 수학내신, 고등 수능대비까지 학생 진도에 맞춘 1:1 수학수업. 전화 상담 $phone"
        $dongFaq = Get-AreaFaq $dongName
        $dongLd = (Get-BreadcrumbLd @(@('대전 수학과외', "$siteUrl/"), @("$districtArea 수학과외", $districtUrl), @("$dongName 수학과외", $dongUrl))) + (Get-FaqLd $dongFaq)
        $dongHead = Get-Head $dongTitle $dongDescription $dongUrl '../../../styles.css' $dongLd
        $dongHeader = Get-Header '../../../'
        $dongLevels = Get-LevelSection $dongName $district.Name '../'
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
        <div class="location-intro-copy"><p>$($district.Character)</p><p>$dongName 수학과외는 현재 사용하는 교재와 최근 시험 결과를 먼저 살펴봅니다. 정답 개수만 확인하지 않고 개념 이해, 풀이 순서, 계산 습관 중 어디에서 막혔는지 구분해 다음 학습량을 정합니다.</p><p>초등학생, 중1·중2·중3, 고1·고2·고3 등 학년별로 필요한 목표가 다르기 때문에 $dongName 초등수학, 중등수학, 고등수학 수업은 상담에서 학년과 목표를 확인한 뒤 계획합니다.</p><p>대면 수업 가능 여부와 시간은 학생의 학년, $dongName 내 위치, 희망 일정에 따라 상담 후 안내합니다. 온라인 수업도 학습 상황에 맞춰 협의할 수 있습니다.</p></div>
      </section>
$dongLevels
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
$dongCount = $pages.Count - $districts.Count - $levelCount - $hubCount - $guides.Count - 1
Write-Output "Generated $($districts.Count) district, $levelCount grade-level, $hubCount neighborhood hub, $dongCount neighborhood and $($guides.Count) guide pages."
