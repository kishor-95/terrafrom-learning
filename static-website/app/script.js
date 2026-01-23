// Data Definition
const skills = [
    { id: 'k8s', name: 'Kubernetes', level: 90, desc: 'Cluster orchestration, Helm charts, Operator patterns.' },
    { id: 'tf', name: 'Terraform', level: 85, desc: 'Infrastructure as Code, Multi-cloud provisioning, State management.' },
    { id: 'aws', name: 'AWS', level: 88, desc: 'EC2, S3, RDS, Lambda, VPC networking architecture.' },
    { id: 'docker', name: 'Docker', level: 95, desc: 'Containerization, Multi-stage builds, Optimization.' },
    { id: 'ci', name: 'CI/CD', level: 92, desc: 'GitHub Actions, Jenkins pipelines, ArgoCD.' },
    { id: 'py', name: 'Python', level: 80, desc: 'Automation scripts, Boto3, API development.' },
    { id: 'go', name: 'Golang', level: 75, desc: 'Backend services, CLI tools, High concurrency.' },
    { id: 'linux', name: 'Linux', level: 98, desc: 'Kernel tuning, Bash scripting, System hardening.' }
];

const commands = {
    'help': 'Available commands: help, skills, status, clear, about, social, theme, reboot',
    'skills': 'Listing skill modules...',
    'status': 'Running system diagnostics...',
    'clear': 'Clearing terminal buffer...',
    'about': 'SYS_ADMIN: Senior DevOps Engineer specializing in scalable infrastructure and automation.',
    'social': 'Github: @devops_ghost | LinkedIn: /in/sysadmin',
    'reboot': 'Initiating reboot sequence...',
    'theme': 'Usage: theme [green|blue|amber]'
};

// DOM Elements
const els = {
    grid: document.getElementById('skill-grid'),
    detailPanel: document.getElementById('skill-details'),
    detailTitle: document.getElementById('detail-title'),
    detailDesc: document.getElementById('detail-desc'),
    detailMeter: document.getElementById('detail-meter'),
    logWindow: document.getElementById('log-window'),
    cmdInput: document.getElementById('cmd-input'),
    focusBar: document.getElementById('bar-focus'),
    focusVal: document.getElementById('val-focus'),
    coffeeBar: document.getElementById('bar-coffee'),
    coffeeVal: document.getElementById('val-coffee'),
    uptimeVal: document.getElementById('val-uptime'),
    healthVal: document.getElementById('val-health')
};

// State
let startTime = Date.now();
const bootTime = new Date().toISOString();

// Initialize
function init() {
    renderSkills();
    loadTheme();
    systemLoop();
    addLog(`SYSTEM BOOT SEQUENCE INITIATED AT ${bootTime}`);
    addLog(`KERNEL LOADED. USER: ROOT`);
    addLog(`Ready for input. Type 'help' for instructions.`);
    
    els.cmdInput.addEventListener('keydown', handleCommand);
    
    // Theme buttons
    document.querySelectorAll('.theme-btn').forEach(btn => {
        btn.addEventListener('click', () => setTheme(btn.dataset.color));
    });
}

// Render Skills
function renderSkills() {
    els.grid.innerHTML = '';
    skills.forEach(skill => {
        const div = document.createElement('div');
        div.className = 'skill-node';
        div.textContent = skill.name;
        div.onclick = () => showSkillDetails(skill, div);
        els.grid.appendChild(div);
    });
}

function showSkillDetails(skill, element) {
    // Styling
    document.querySelectorAll('.skill-node').forEach(el => el.classList.remove('active'));
    element.classList.add('active');
    
    // Content
    els.detailPanel.classList.remove('hidden');
    els.detailTitle.textContent = `MODULE: ${skill.name.toUpperCase()}`;
    els.detailDesc.textContent = skill.desc;
    
    // Animation reset
    els.detailMeter.style.width = '0%';
    setTimeout(() => {
        els.detailMeter.style.width = `${skill.level}%`;
    }, 50);
    
    addLog(`Accessed module: ${skill.name} // Proficiency: ${skill.level}%`);
}

// Logging System
function addLog(msg, type = 'info') {
    const div = document.createElement('div');
    const time = new Date().toLocaleTimeString('en-US', { hour12: false });
    div.className = `log-entry ${type === 'error' ? 'error' : ''} ${type === 'highlight' ? 'highlight' : ''}`;
    div.innerHTML = `<span class="log-time">[${time}]</span> ${msg}`;
    els.logWindow.appendChild(div);
    els.logWindow.scrollTop = els.logWindow.scrollHeight;
}

// Command Handling
function handleCommand(e) {
    if (e.key !== 'Enter') return;
    
    const input = els.cmdInput.value.trim();
    const args = input.split(' ');
    const cmd = args[0].toLowerCase();
    
    if (!input) return;
    
    addLog(`root@portfolio:~$ ${input}`, 'highlight');
    els.cmdInput.value = '';

    if (commands[cmd]) {
        addLog(commands[cmd]);
        executeAction(cmd, args);
    } else {
        addLog(`Command not found: ${cmd}. Type 'help'.`, 'error');
        // Random chance to "crash"
        if (Math.random() > 0.95) triggerError();
    }
}

function executeAction(cmd, args) {
    switch(cmd) {
        case 'clear':
            els.logWindow.innerHTML = '';
            break;
        case 'skills':
            els.grid.scrollIntoView({ behavior: 'smooth' });
            break;
        case 'reboot':
            setTimeout(() => location.reload(), 1500);
            break;
        case 'theme':
            const color = args[1];
            if (['green', 'blue', 'amber'].includes(color)) {
                const map = { green: 'neon-green', blue: 'cyber-blue', amber: 'alert-amber' };
                setTheme(map[color]);
                addLog(`Theme set to ${color}`);
            } else {
                addLog('Invalid theme. Use: green, blue, amber', 'error');
            }
            break;
    }
}

// Metrics Loop
function systemLoop() {
    setInterval(() => {
        // Uptime
        const elapsed = Math.floor((Date.now() - startTime) / 1000);
        const h = String(Math.floor(elapsed / 3600)).padStart(2, '0');
        const m = String(Math.floor((elapsed % 3600) / 60)).padStart(2, '0');
        const s = String(elapsed % 60).padStart(2, '0');
        els.uptimeVal.textContent = `${h}:${m}:${s}`;
    }, 1000);

    setInterval(() => {
        // Random metrics
        const focus = Math.floor(Math.random() * (100 - 85) + 85);
        els.focusBar.style.width = `${focus}%`;
        els.focusVal.textContent = `${focus}%`;

        // Coffee (slowly decreasing)
        const coffee = Math.max(0, 500 - Math.floor((Date.now() - startTime) / 1000));
        els.coffeeBar.style.width = `${(coffee / 500) * 100}%`;
        els.coffeeVal.textContent = `${coffee}mL`;
        
        // Status Text
        const statuses = ['OPTIMAL', 'COMPILING', 'DEPLOYING', 'MONITORING'];
        els.healthVal.textContent = statuses[Math.floor(Math.random() * statuses.length)];
    }, 3000);
}

// Theme Controller
function setTheme(themeName) {
    document.documentElement.setAttribute('data-theme', themeName);
    localStorage.setItem('sys-theme', themeName);
}

function loadTheme() {
    const saved = localStorage.getItem('sys-theme') || 'neon-green';
    setTheme(saved);
}

function triggerError() {
    window.location.href = 'error.html';
}

// Boot
init();