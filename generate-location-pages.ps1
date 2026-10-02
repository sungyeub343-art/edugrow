$ErrorActionPreference = 'Stop'

$siteUrl = 'https://edugrow.kr'
$verification = '5102b73793afd2b7a181cc7610526b5c668970b5'
$googleVerification = '30EmtwePj6A4sjdlOnIHnXM_PbOWzJkuM_wnzxn-6oo'
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

function Write-Utf8File([string]$Path, [string]$Content) {
    $directory = Split-Path -Parent $Path
    if (-not (Test-Path $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $utf8)
}

function Get-Head([string]$Title, [string]$Description, [string]$Canonical, [string]$StylePath) {
    return @"
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$Title</title>
  <meta name="description" content="$Description">
  <meta name="naver-site-verification" content="$verification">
  <meta name="google-site-verification" content="$googleVerification">
  <meta name="theme-color" content="#17352b">
  <meta property="og:type" content="website">
  <meta property="og:title" content="$Title">
  <meta property="og:description" content="$Description">
  <meta property="og:url" content="$Canonical">
  <link rel="canonical" href="$Canonical">
  <link rel="icon" href="/logo.svg" type="image/svg+xml">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&family=Pretendard:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="$StylePath">
"@
}

function Get-Header([string]$HomePath, [string]$ContactPath) {
    return @"
  <a class="skip-link" href="#main">본문으로 바로가기</a>
  <header class="site-header" id="top">
    <a class="brand" href="$HomePath" aria-label="대전 수학과외 홈"><span class="brand-mark" aria-hidden="true">∑</span><span>대전 수학과외</span></a>
    <nav class="desktop-nav" aria-label="주요 메뉴"><a href="$HomePath#approach">수업 방식</a><a href="$HomePath#program">학년별 수업</a><a href="$HomePath#area">수업 지역</a></nav>
    <a class="header-cta" href="$ContactPath">상담 신청</a>
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

function Get-Footer([string]$HomePath) {
    return @"
  <footer>
    <a class="brand footer-brand" href="$HomePath"><span class="brand-mark" aria-hidden="true">∑</span><span>대전 수학과외</span></a>
    <p>학생의 이해에서 시작하는 1:1 맞춤 수업</p>
    <p class="copyright">© 2026 대전 수학과외</p>
  </footer>
"@
}

$allUrls = New-Object System.Collections.Generic.List[string]
$allUrls.Add("$siteUrl/")

foreach ($district in $districts) {
    $districtUrl = "$siteUrl/areas/$($district.Slug)/"
    $allUrls.Add($districtUrl)
    $dongLinks = New-Object System.Collections.Generic.List[string]

    foreach ($dongEntry in $district.Dongs) {
        $parts = $dongEntry.Split('|')
        $dongSlug = $parts[0]
        $dongName = $parts[1]
        $dongLinks.Add("        <a href=`"$dongSlug/`"><span>$dongName 수학과외</span><span aria-hidden=`"true`">→</span></a>")
        $dongUrl = "$districtUrl$dongSlug/"
        $allUrls.Add($dongUrl)
        $nearbyLinks = $district.Dongs | Where-Object { $_ -ne $dongEntry } | Select-Object -First 7 | ForEach-Object {
            $nearParts = $_.Split('|')
            "        <a href=`"../$($nearParts[0])/`"><span>$($nearParts[1]) 수학과외</span><span aria-hidden=`"true`">→</span></a>"
        }
        $dongTitle = "$dongName 수학과외 | 대전 $($district.Name) 1:1 맞춤 수업"
        $dongDescription = "대전 $($district.Name) $dongName 초중고 1:1 수학과외. 예비중1, 예비중2, 예비중3, 예비고1, 예비고2, 예비고3 학생의 현재 진도에 맞춰 학습 계획을 세웁니다."
        $dongHead = Get-Head $dongTitle $dongDescription $dongUrl '../../../styles.css'
        $dongHeader = Get-Header '../../../' '../../../#contact'
        $dongGradeGuide = Get-GradeGuide "$($district.Name) $dongName"
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
      <p>${dongName}에서 초등 개념부터 중등 내신, 고등 수능 기초까지 학생의 이해 속도에 맞춰 수업 방향을 정합니다.</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">LOCAL TUTORING</p><h2 id="intro-title">가까운 곳에서<br>꾸준히 배우는 수학</h2></div>
        <div class="location-intro-copy"><p>$($district.Character)</p><p>$dongName 수학과외는 현재 사용하는 교재와 최근 시험 결과를 먼저 살펴봅니다. 정답 개수만 확인하지 않고 개념 이해, 풀이 순서, 계산 습관 중 어디에서 막혔는지 구분해 다음 학습량을 정합니다.</p><p>대면 수업 가능 여부와 시간은 학생의 학년, $dongName 내 위치, 희망 일정에 따라 상담 후 안내합니다. 온라인 수업도 학습 상황에 맞춰 협의할 수 있습니다.</p></div>
      </section>
$dongGradeGuide
      <section class="local-list" aria-labelledby="nearby-title"><p class="section-number">NEARBY AREA</p><h2 id="nearby-title">$($district.Name) 다른 지역 수학과외</h2><div class="area-links">$($nearbyLinks -join "`n")</div></section>
      <section class="location-cta"><div><p class="section-number">CONTACT</p><h2>$dongName 수학과외 상담</h2></div><a class="button" href="../../../#contact">상담 신청하기</a></section>
    </div>
  </main>
$dongFooter</body>
</html>
"@
        Write-Utf8File (Join-Path $PSScriptRoot "areas\$($district.Slug)\$dongSlug\index.html") $dongHtml
    }

    $districtTitle = "대전 $($district.Name) 수학과외 | 초중고 1:1 맞춤 수업"
    $districtDescription = "대전 $($district.Name) 초중고 수학과외. 예비중1부터 예비고3까지 학생별 진단과 학습 계획을 바탕으로 1:1 수업을 진행합니다."
    $districtHead = Get-Head $districtTitle $districtDescription $districtUrl '../../styles.css'
    $districtHeader = Get-Header '../../' '../../#contact'
    $districtGradeGuide = Get-GradeGuide "대전 $($district.Name)"
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
      <h1>대전 $($district.Name)<br>수학과외</h1>
      <p>$($district.Character)</p>
    </section>
    <div class="location-layout">
      <section class="location-intro" aria-labelledby="intro-title">
        <div><p class="section-number">LOCAL TUTORING</p><h2 id="intro-title">학교 진도와<br>학생의 속도를 함께</h2></div>
        <div class="location-intro-copy"><p>대전 $($district.Name) 수학과외는 최근 시험지와 교재, 평소 학습 시간을 확인하는 진단에서 시작합니다. 같은 학년이라도 개념의 빈틈과 목표가 다르기 때문에 설명 방식과 과제량을 학생별로 조정합니다.</p><p>초등 수학의 개념과 연산, 중등 내신의 서술형 풀이, 고등 수학의 개념 연결과 문제 해석까지 현재 필요한 단계에 집중합니다.</p></div>
      </section>
$districtGradeGuide
      <section class="local-list" aria-labelledby="dong-title"><p class="section-number">$($district.Dongs.Count) AREAS</p><h2 id="dong-title">$($district.Name) 동별 수학과외</h2><div class="area-links">$($dongLinks -join "`n")</div></section>
      <section class="location-cta"><div><p class="section-number">CONTACT</p><h2>대전 $($district.Name) 수학과외 상담</h2></div><a class="button" href="../../#contact">상담 신청하기</a></section>
    </div>
  </main>
$districtFooter</body>
</html>
"@
    Write-Utf8File (Join-Path $PSScriptRoot "areas\$($district.Slug)\index.html") $districtHtml
}

$sitemapEntries = $allUrls | ForEach-Object { "  <url><loc>$_</loc><lastmod>2026-10-01</lastmod></url>" }
$sitemap = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
$($sitemapEntries -join "`n")
</urlset>
"@
Write-Utf8File (Join-Path $PSScriptRoot 'sitemap.xml') $sitemap
Write-Output "Generated $($districts.Count) district pages and $($allUrls.Count - $districts.Count - 1) neighborhood pages."