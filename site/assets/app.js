document.getElementById('time').textContent = new Date().toLocaleString('zh-CN', {
  timeZone: 'Asia/Shanghai',
});
document.getElementById('year').textContent = new Date().getFullYear();

// 从响应头拿 CloudFront POP 信息（需要 CloudFront 函数注入，
// 简单场景下用 /cdn-cgi/trace 替代或直接展示当前域名）
fetch(window.location.href, { method: 'HEAD' }).then((res) => {
  const pop = res.headers.get('x-amz-cf-pop') || 'CDN Edge';
  document.getElementById('pop').textContent = pop;
});