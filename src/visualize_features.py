#!/usr/bin/env python3
"""
visualize_features.py

Generate analysis charts from dataset_combined.csv (42 samples).
Outputs saved to data/results/figures/

Figures produced:
  fig1_label_distribution.png
  fig2_pearson_r_vs_ratio.png
  fig3_cohens_d.png
  fig4_boxplots_by_label.png
  fig5_ratio_by_label.png
  fig6_scatter_matrix.png
  fig7_correlation_heatmap.png
"""

import csv
import math
from collections import Counter
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

ROOT    = Path("/code")
DATA    = ROOT / "data" / "results" / "dataset_combined.csv"
FIGDIR  = ROOT / "data" / "results" / "figures"
FIGDIR.mkdir(parents=True, exist_ok=True)

LABEL_COLORS = {
    "native-better": "#d95f02",
    "similar":       "#1b9e77",
    "wasm-better":   "#7570b3",
}
LABEL_ORDER = ["native-better", "similar", "wasm-better"]

# ---------- load ----------
rows   = list(csv.DictReader(DATA.open("r", encoding="utf-8", newline="")))
n      = len(rows)
labels = [r["label"] for r in rows]
ratio  = np.array([float(r["ratio_wasm_over_native"]) for r in rows])
y_bin  = np.array([1 if r["label"] == "native-better" else 0 for r in rows], dtype=int)
exclude = {"program", "label", "native_median_ms", "wasm_median_ms", "ratio_wasm_over_native"}
FEATS  = [c for c in rows[0].keys() if c not in exclude]
X      = np.array([[float(r[c]) for c in FEATS] for r in rows], dtype=float)
label_counts = Counter(labels)

def save(name):
    p = FIGDIR / name
    plt.savefig(p, dpi=150, bbox_inches="tight")
    plt.close()
    print("saved", p)

# ---------- Cohen d ----------
effects = []
for j, c in enumerate(FEATS):
    a, b = X[y_bin==1, j], X[y_bin==0, j]
    ma, mb = np.mean(a), np.mean(b)
    va = float(np.var(a, ddof=1)) if len(a)>1 else 0.0
    vb = float(np.var(b, ddof=1)) if len(b)>1 else 0.0
    pooled = ((len(a)-1)*va+(len(b)-1)*vb)/max(len(a)+len(b)-2,1)
    d = 0.0 if pooled<=1e-12 else (ma-mb)/math.sqrt(pooled)
    effects.append((c, d))
effects.sort(key=lambda t: abs(t[1]), reverse=True)

# ---------- Pearson vs ratio ----------
corr_ratio = []
for j, c in enumerate(FEATS):
    x = X[:,j]
    r = float(np.corrcoef(x, ratio)[0,1]) if np.std(x)>0 else 0.0
    corr_ratio.append((c, r))
corr_ratio.sort(key=lambda t: abs(t[1]), reverse=True)

# ---------- Pearson vs label ----------
corr_bin = []
for j, c in enumerate(FEATS):
    x = X[:,j]
    r = float(np.corrcoef(x, y_bin)[0,1]) if np.std(x)>0 else 0.0
    corr_bin.append((c, r))

corr_bin_sorted = sorted(corr_bin, key=lambda t: abs(t[1]), reverse=True)
import matplotlib.patches as mpatches

def save(name):
    p = FIGDIR / name
    plt.savefig(p, dpi=150, bbox_inches="tight")
    plt.close()
    print("saved", p)

# Fig 1
fig, ax = plt.subplots(figsize=(6,4))
counts=[label_counts.get(l,0) for l in LABEL_ORDER]
clrs=[LABEL_COLORS[l] for l in LABEL_ORDER]
bars=ax.bar(LABEL_ORDER,counts,color=clrs,edgecolor="white",linewidth=1.2)
for bar,cnt in zip(bars,counts):
    ax.text(bar.get_x()+bar.get_width()/2,bar.get_height()+0.4,str(cnt),
            ha="center",va="bottom",fontsize=11,fontweight="bold")
ax.set_ylabel("Sample count",fontsize=11)
ax.set_title(f"Label distribution  (n={n})",fontsize=13,fontweight="bold")
ax.set_ylim(0,max(counts)*1.2)
ax.spines[["top","right"]].set_visible(False)
plt.tight_layout();save("fig1_label_distribution.png")

# Fig 2
top12_cr=corr_ratio[:12]
nm_cr=[t[0] for t in top12_cr];v_cr=[t[1] for t in top12_cr]
cl_cr=["#d95f02" if v>=0 else "#7570b3" for v in v_cr]
fig,ax=plt.subplots(figsize=(8,5))
ax.barh(nm_cr[::-1],v_cr[::-1],color=cl_cr[::-1],edgecolor="white")
ax.axvline(0,color="black",linewidth=0.8,linestyle="--")
for i,v in enumerate(v_cr[::-1]):
    ax.text(v+(0.01 if v>=0 else -0.01),i,f"{v:.3f}",va="center",ha="left" if v>=0 else "right",fontsize=8)
ax.set_xlabel("Pearson r",fontsize=11)
ax.set_title("Feature correlation with ratio_wasm_over_native  (Top 12 by |r|)",fontsize=11,fontweight="bold")
ax.spines[["top","right"]].set_visible(False)
plt.tight_layout();save("fig2_pearson_r_vs_ratio.png")

# Fig 3
top12_ef=effects[:12]
nm_ef=[t[0] for t in top12_ef];v_ef=[t[1] for t in top12_ef]
cl_ef=["#d95f02" if v>=0 else "#7570b3" for v in v_ef]
fig,ax=plt.subplots(figsize=(8,5))
ax.barh(nm_ef[::-1],v_ef[::-1],color=cl_ef[::-1],edgecolor="white")
ax.axvline(0,color="black",linewidth=0.8,linestyle="--")
for i,v in enumerate(v_ef[::-1]):
    ax.text(v+(0.02 if v>=0 else -0.02),i,f"{v:.3f}",va="center",ha="left" if v>=0 else "right",fontsize=8)
ax.set_xlabel("Cohen d  (native-better minus non-native)",fontsize=11)
ax.set_title("Feature discriminability: native-better vs non-native  (Top 12)",fontsize=11,fontweight="bold")
pat=[mpatches.Patch(color="#d95f02",label="native-better higher"),
     mpatches.Patch(color="#7570b3",label="non-native higher")]
ax.legend(handles=pat,fontsize=9,loc="lower right")
ax.spines[["top","right"]].set_visible(False)
plt.tight_layout();save("fig3_cohens_d.png")

# Fig 4
top8=[t[0] for t in effects[:8]]
la={l:[] for l in LABEL_ORDER}
for row,lab in zip(rows,labels):
    la[lab].append([float(row[f]) for f in top8])
la={k:np.array(v) for k,v in la.items() if v}
fig,axes=plt.subplots(2,4,figsize=(14,7))
for idx,feat in enumerate(top8):
    ax=axes[idx//4,idx%4];dg,tl,tc=[],[],[]
    for l in LABEL_ORDER:
        if l in la:
            dg.append(la[l][:,idx]);tl.append(l.replace("-","\n"));tc.append(LABEL_COLORS[l])
    bp=ax.boxplot(dg,patch_artist=True,widths=0.5,medianprops=dict(color="black",linewidth=1.5))
    for patch,col in zip(bp["boxes"],tc):
        patch.set_facecolor(col);patch.set_alpha(0.75)
    ax.set_xticklabels(tl,fontsize=8);ax.set_title(feat,fontsize=9,fontweight="bold")
    ax.spines[["top","right"]].set_visible(False)
fig.suptitle("Feature distributions by label  (top 8 by Cohen |d|)",fontsize=13,fontweight="bold")
plt.tight_layout();save("fig4_boxplots_by_label.png")

# Fig 5
rbl={l:[] for l in LABEL_ORDER}
for row,lab in zip(rows,labels):
    rbl[lab].append(float(row["ratio_wasm_over_native"]))
fig,ax=plt.subplots(figsize=(7,5))
for pos,lab in enumerate(LABEL_ORDER):
    vals=rbl.get(lab,[])
    if not vals:continue
    vp=ax.violinplot([vals],positions=[pos],showmedians=True)
    for body in vp["bodies"]:body.set_facecolor(LABEL_COLORS[lab]);body.set_alpha(0.6)
    for part in ["cmedians","cmins","cmaxes","cbars"]:vp[part].set_color("black" if part=="cmedians" else "gray")
    jitter=np.random.default_rng(42).uniform(-0.08,0.08,len(vals))
    ax.scatter([pos+j for j in jitter],vals,color=LABEL_COLORS[lab],s=28,alpha=0.85,zorder=3)
ax.axhline(1.0,color="black",lw=1,ls="--",alpha=0.5,label="ratio=1.0")
ax.axhline(1.1,color="gray",lw=0.8,ls=":",alpha=0.5,label="threshold=1.1")
ax.set_xticks(range(len(LABEL_ORDER)));ax.set_xticklabels(LABEL_ORDER,fontsize=11)
ax.set_ylabel("ratio_wasm_over_native",fontsize=11)
ax.set_title("Wasm/Native performance ratio by label",fontsize=13,fontweight="bold")
ax.legend(fontsize=9);ax.spines[["top","right"]].set_visible(False)
plt.tight_layout();save("fig5_ratio_by_label.png")

# Fig 6
top6=[t[0] for t in effects[:6]]
top6i=[FEATS.index(f) for f in top6];X6=X[:,top6i]
pt_colors=[LABEL_COLORS[l] for l in labels]
fig,axes=plt.subplots(6,6,figsize=(13,12))
for i in range(6):
    for j in range(6):
        ax=axes[i,j]
        if i==j:
            for l in LABEL_ORDER:
                mask=np.array([lb==l for lb in labels])
                ax.hist(X6[mask,i],bins=10,alpha=0.55,color=LABEL_COLORS[l],density=True,linewidth=0)
            ax.set_title(top6[i],fontsize=7,fontweight="bold")
        else:
            ax.scatter(X6[:,j],X6[:,i],c=pt_colors,s=14,alpha=0.75,linewidths=0)
        ax.tick_params(labelsize=5)
        if j==0:ax.set_ylabel(top6[i],fontsize=7)
        if i==5:ax.set_xlabel(top6[j],fontsize=7)
        ax.spines[["top","right"]].set_visible(False)
leg=[mpatches.Patch(color=LABEL_COLORS[l],label=l) for l in LABEL_ORDER]
fig.legend(handles=leg,loc="upper right",fontsize=9,bbox_to_anchor=(1.0,1.0))
fig.suptitle("Scatter matrix  top 6 features (Cohen |d|)",fontsize=12,fontweight="bold")
plt.tight_layout(rect=[0,0,0.97,0.97]);save("fig6_scatter_matrix.png")

# Fig 7
cr_map=dict(corr_ratio);cb_map=dict(corr_bin)
cr_vec=np.array([cr_map[f] for f in FEATS]);cb_vec=np.array([cb_map[f] for f in FEATS])
order=np.argsort(np.abs(cr_vec))[::-1]
matrix=np.stack([cr_vec[order],cb_vec[order]],axis=1)
ylbls=[FEATS[i] for i in order]
fig,ax=plt.subplots(figsize=(4.5,10))
im=ax.imshow(matrix,aspect="auto",cmap="RdBu_r",vmin=-1,vmax=1)
plt.colorbar(im,ax=ax,shrink=0.5,label="Pearson r")
ax.set_xticks([0,1]);ax.set_xticklabels(["vs ratio","vs label(native=1)"],fontsize=10)
ax.set_yticks(range(len(ylbls)));ax.set_yticklabels(ylbls,fontsize=8)
for i in range(len(ylbls)):
    for j in range(2):
        v=matrix[i,j]
        ax.text(j,i,f"{v:.2f}",ha="center",va="center",fontsize=7,
                color="white" if abs(v)>=0.55 else "black")
ax.set_title("Correlation heatmap (sorted by |r vs ratio|)",fontsize=12,fontweight="bold")
plt.tight_layout();save("fig7_correlation_heatmap.png")

print("All figures saved to",FIGDIR)
